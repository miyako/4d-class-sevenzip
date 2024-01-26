# SevenZip : _CLI

`SevenZip` is a subclass of `_CLI` to execute the `7z` program. 

## .add()

**.add**($destination : 4D.File; $sources : Variant)->$this : cs.SevenZip

Adds a collection of `4D.File` or `4D.Folder` objects to an archive. Alternatively archive a single object.

Chained calls are queued as sequential tasks.

## .extract()

**.extract**($destination : 4D.Folder; $sources : Variant)->$this : cs.SevenZip

Extracts all files from an archive.

Chained calls are queued as sequential tasks.
