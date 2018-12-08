System.config({
    transpiler: "plugin-babel",
    paths: {
        "npm:": "https://unpkg.com/"
    },
    defaultExtension: "js",
    map: {
        react: "npm:react@16/umd/react.development.js",
        "react-dom": "npm:react-dom@16/umd/react-dom.development.js",
        "prop-types": "npm:prop-types/prop-types.js",

        devextreme: "npm:devextreme@18.2",
        "devextreme-react": "npm:devextreme-react@18.2",
        jszip: "npm:jszip@3.1.3/dist/jszip.min.js",
        quill: "npm:quill@1.3.6/dist/quill.js",
        "quill-delta-to-html":
        "npm:quill-delta-to-html@0.10.4/dist/browser/QuillDeltaToHtmlConverter.bundle.js",

        // SystemJS plugins
        "plugin-babel": "npm:systemjs-plugin-babel@0/plugin-babel.js",
        "systemjs-babel-build":
        "npm:systemjs-plugin-babel@0/systemjs-babel-browser.js"
    },
    packages: {
        devextreme: {
        defaultExtension: "js"
        },
        "devextreme-react": {
        main: "index.js"
        }
    },
    babelOptions: {
        sourceMaps: false,
        stage0: true,
        react: true
    }
});
