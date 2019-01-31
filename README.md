# SNExceptionGuarder
runtime crash protector.

## 功能介绍
利用Objective-C动态的语言特性，在App将要崩溃（抛出异常）时捕获异常进行处理，进行信息上报，保证App继续正常运行。其主要面向8个方面：

- Unrecognized Selector Crash
- NSDictionary Crash
- NSArray Crash
- NSSet Crash
- NSString Crash
- NSAttributeString Crash
- NSTimer Crash
- Bad Access Crash

## 使用方法

```
pod 'SNExceptionGuarder'
```

```
// 配置异常捕获后的上报操作.
[SNExceptionGuarder configWithBlock:^(NSDictionary * _Nonnull params) {
    //上报操作
    NSLog(@"___捕获到异常：%@",params);
}];

// 配置允许捕获的异常类型，默认SNExceptionGuarderTypeNone.
[SNExceptionGuarder configExceptionGuarderType:SNExceptionGuarderTypeAll];
    
// 配置允许Zombie异常捕获的类.
[SNExceptionGuarder addZombieObjectArray:@[NSClassFromString(@"BViewController")]];  

// 开启异常捕获功能.
[SNExceptionGuarder startGuardException];

// 关闭异常捕获功能.
[SNExceptionGuarder stopGuardException];
```


