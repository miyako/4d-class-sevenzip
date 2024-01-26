![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-class-sevenzip)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-class-sevenzip/total)

# 4d-class-sevenzip
[Classes](https://github.com/miyako/4d-class-sevenzip/tree/main/Project/Sources/Classes) to process archive files with the 7z program.

![](https://github.com/miyako/4d-class-sevenzip/assets/1725068/4206daca-5722-4cf5-a41e-e6a4499ca551)

## Examples

### Archive

```4d
$sevenzip:=cs.SevenZip.new(cs._SevenZip_Controller)
$sevenzip.add(File("test.7z"); New collection(File("a.txt"); File("b.txt"); File("c.txt")))
```

### Expand

```4d
$sevenzip:=cs.SevenZip.new(cs._SevenZip_Controller)
$sevenzip.extract(Folder(fk desktop folder); File("test.7z"))
```
