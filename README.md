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
