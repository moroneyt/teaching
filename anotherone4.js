import hljs from 'https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.3.1/build/es/highlight.min.js';
//  and it's easy to individually load & register additional languages
import matlab from 'https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.3.1/build/es/languages/matlab.min.js';
hljs.registerLanguage('matlab', matlab);
