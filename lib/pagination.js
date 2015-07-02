var mongoose = require('mongoose');
var _ = require('lodash');

mongoose.Query.prototype.paginate = function paginate (page, limit, cb) {

  page  = parseInt(page, 10) || 1;
  limit = parseInt(limit, 10) || 10;

  var query = this;
  var model = this.model;
  var skipFrom = (page * limit) - limit;

  query = query.skip(skipFrom).limit(limit);

  if(cb) {
    query.exec(function(err, docs) {
      if(err) {
        cb(err, null, null);
      } else {
        model.count(query._conditions, function(err, total) {
          if(err) {
            cb(err, null, null);
          } else {
            cb(null, docs, total);
          }
        });
      }
    });
  } else {
    return this;
  }
};

mongoose.Types.Array.mixin.paginate = function (page, limit, cb) {

  page  = parseInt(page, 10) || 1;
  limit = parseInt(limit, 10) || 10;

  try {
    var items = this.toObject();
    var chunkedItems = _.chunk(items, limit);
    var docs = page <= chunkedItems.length
      ? chunkedItems[page - 1]
      : [];
    var total = items.length;
    cb(null, docs, total);
  } catch (err) {
    cb(err);
  }
};

