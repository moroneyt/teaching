import hljs from 'https://unpkg.com/@highlightjs/cdn-assets@11.3.1/es/highlight.min.js';
//  and it's easy to individually load & register additional languages
import go from 'https://unpkg.com/@highlightjs/cdn-assets@11.3.1/es/languages/matlab.min.js';
hljs.registerLanguage('matlab', matlab);
