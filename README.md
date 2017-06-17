# ios-app-CoreDataSample

EasyMapping＆CoreDataのサンプル。

EasyMappingを使って、JSONを`NSManagedObject`に変換して永続ストアに保存。

また逆に、永続ストアから`NSManagedObject`を読み出し（フェッチ）。

## Testクラス

サンプルに含まれるTestクラスは、EasyMappingの`EKManagedObjectModel`クラスのサブクラス。

`EKManagedObjectModel`は`NSManagedObject`のサブクラス。

サンプルでは、JSONからTestクラスのオブジェクトを生成し、永続ストアに保存。

また永続ストアからTestオブジェクトをフェッチ。
