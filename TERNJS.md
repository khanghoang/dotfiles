#How to use TernJS in the project
- Install [ternjs/tern_for_vim](ternjs/tern_for_vim)
- Go to root file of the project and create `.tern-project` which contains:
```
{
  "ecmaVersion": 6,
  "loadEagerly": [
    "app/**/*.js"
  ],
  "dontLoad": [
    "node_modules/**"
  ],
  "plugins": {
    "es_modules": {},
    "commonjs": {}
  }
}
```
- use `TernDef` will jump to definition of the word under current cusor.
