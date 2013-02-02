exports.install = (mod) ->
  mod.Query::paginate = paginate


paginate = (page, limit, cb) ->
  page = parseInt(page, 10) or 1
  limit = parseInt(limit, 10) or 10
  query = @
  model = @model
  skipFrom = (page * limit) - limit
  query = query.skip(skipFrom).limit(limit)

  if cb
    query.exec (err, docs) ->
      if err
        cb err, null, null
      else
        model.count query._conditions, (err, total) ->
          if err
            cb err, null, null
          else
            cb null, docs, total
  else
    @
