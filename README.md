# JS Bin Processors

This is the server to handle processors. Though most of JS Bin's processors are handled both on the client side and server side, *some* processors need to be server side only (like Sass), but also they need to be (effectively) "thread safe".

This server will respond to zeromq messages with appropriate source types, and respond with the translated output.

## Creating a processor target

All processors live in the `targets` directory, and are structured as so:

1. Directory name for the target processor (such as `markdown`)
2. `index.js` will be loaded by the processor server
3. `module.exports` is a function that receives `resolve`, `reject` and `data`
4. `data` is an object with `language` (which maps to the target processor) `source`, `url` (i.e. "abc" in [JS Bin's pronounceable urls](http://jsbin.com/help/pronounceable-urls)) and `revision` (for now).
5. The processor must handle *both* the resolve and the reject.

### Simple example with markdown

The directory structure:

```text
.
└── targets
    └── markdown
        └── index.js
```

The `package.json` for *this* project includes the `markdown` npm module.

`index.js` contains:

```js
'use strict';

var markdown = require('markdown').markdown;

module.exports = function (resolve, reject, data) {
  try {
    resolve(markdown.toHTML(data.source));
  } catch (e) {
    reject(e);
  }
};
```

Now the processor server can handle requests for markdown conversion.