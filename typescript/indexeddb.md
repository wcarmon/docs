# Overview
1. Info on the primary universally-supported option for browser based Blob storage


# Definitions
1. Database: 
    - highest level concept
    - can have multiple databases
    - has multiple [`ObjectStore`s](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API/Basic_Terminology#object_store) 
    - [has a `version`](https://developer.mozilla.org/en-US/docs/Web/API/IDBDatabase/version)
    - [has a `name`](https://developer.mozilla.org/en-US/docs/Web/API/IDBDatabase/name)
1. [ObjectStore](https://developer.mozilla.org/en-US/docs/Web/API/IDBObjectStore):
    - like rdbms Table
    - contains records, sorted by keys
    - [can have primary key](https://web.dev/indexeddb/#defining-primary-keys)
    - [can have 1+ indexes](https://web.dev/indexeddb/#defining-indexes)        
1. [Index](https://developer.mozilla.org/en-US/docs/Web/API/IDBIndex):
    - like rdbms Index
1. [Transaction](https://developer.mozilla.org/en-US/docs/Web/API/IDBTransaction):
    - wraps 1+ operations
1. [Cursor](https://developer.mozilla.org/en-US/docs/Web/API/IDBCursor)
    - helps iterate records


# Gotchas
1. API is terrible


# Limits
- TODO: ...


# Alternatives
## File System API
- `Con`: [Chrome only](https://caniuse.com/filesystem)
- `Con`: user must grant permission, on each session  

## ~~LocalStorage~~
- `Con`: synchronous (blocks UI)
- `Con`: limited to 5MB
- `Con`: can only contain strings
- `Con`: not accessible from WebWorkers
- `Pro`: cross-tab

## ~~SessionStorage~~
- `Con`: tab specific
- `Con`: more complex than just using `window` without any benefit
- `Con`: limited to 5MB
- `Con`: can only contain strings
- `Con`: erased when tab closed
- `Con`: not accessible from WebWorkers
- `Con`: synchronous (blocks UI)

## ~~WebSQL~~
- `Con`: abandonware
- `Con`: Chrome only


--------
# High-level APIs

## [idb-keyval](https://github.com/jakearchibald/idb-keyval)
- `Pro`: Light/Small
- `Pro`: Tree-shakable
- `Pro`: 2k+ stars on github
- `Pro`: [Good testing](https://github.com/jakearchibald/idb-keyval/blob/main/test/index.ts)
- `Con`: ... 

## [Dexie.js](https://dexie.org/)
- `Pro`: reactive 
- `Pro`: bulk operations
- `Pro`: well documented (examples in multiple popular frameworks, cheatsheet, ...)
- `Pro`: TypeScript compatible
- `Pro`: 9k+ stars on github

## [JsStore](https://jsstore.net/tutorial/get-started/)
- `Pro`: Intuitive for people that know SQL
- `Con`: [May require extra tools to optimize](https://jsstore.net/tutorial/optimization/) 

## localForage
- `Pro`: ... 
- `Pro`: ... 
- `Con`: ... 
- `Con`: ... 

## idb
- `Pro`: ... 
- `Pro`: ... 
- `Con`: ... 
- `Con`: ... 


## [$mol_db](https://github.com/hyoo-ru/mam_mol/tree/master/db)
- `Pro`: ... 
- `Pro`: ... 
- `Con`: ... 
- `Con`: ... 

## [PouchDB](https://pouchdb.com/)
- `Con`: Much wider scope than just IndexedDB 

## ~~MiniMongo~~
- `Con`: feels old-school 
- `Con`: examples have [callback hell](https://github.com/mWater/minimongo#indexeddb) 

## ~~[RxDB](https://rxdb.info/)~~
- `Pro`: reactive
- `Con`: [IndexedDB storage requires purchase](https://rxdb.info/rx-storage-indexeddb.html) 


# Other resources
1. https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API
1. https://developer.chrome.com/docs/devtools/storage/indexeddb/
1. https://firefox-source-docs.mozilla.org/devtools-user/storage_inspector/indexeddb/index.html
1. https://web.dev/indexeddb/
1. https://web.dev/storage-for-the-web/
