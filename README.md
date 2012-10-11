# mongoose-pagination

## Installation

```bash
$ npm install mongoose-pagination
```

## Usage

```javascript
require 'mongoose-pagination'

model
  .find()
  .paginate(1, 10)
  .exec(function(err, docs, total) {
    console.log('total: ', total, 'docs: ', docs)
  });

model
  .find()
  .paginate(1, 10, function(err, docs, total) {
    console.log('total: ', total, 'docs: ', docs)
  });
```

## Tests

```bash
$ npm test
```

## Authors [Christopher Garvis][0] & [Moveline][1]

[0]: http://christophergarvis.com
[1]: http://www.moveline.com

## License

MIT
