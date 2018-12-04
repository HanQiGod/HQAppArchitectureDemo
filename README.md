# HQAppArchitectureDemo

### iOS架构，组件化，响应式架构

组件化似乎是项目发展壮大过后必然要做的事情，它能让各个业务线的工程师不需要过多的关注其他业务线的代码，有效的提高团队整体效率。然而实施组件化的时机是在需求相对稳定、产品闭环形成过后。所以本文不会应用组件化，但是这里简单谈谈业界的组件化方案。

组件化的核心问题就是组件间如何通讯。“软件工程的一切问题都能通过一个间接的中间层解决。”中介模式很自然的运用起来：

![1542853035652480.png](https://img-blog.csdnimg.cn/201812041056369.png)

这样虽然能统一组件间的通讯请求，但是却没有避免 Mediator 和目标组件的耦合，ModuleA 工程中仍然需要导入 ModuleB 。

所以重点问题落在了解耦上：

![1542853050519144.png](https://img-blog.csdnimg.cn/20181204105655776.png)

要达到 Mediator 和目标组件的解耦，就需要实现它们之间的间接调用（图中虚线），既然是间接调用，必然需要一种映射机制。在 iOS 开发中，业界大概有三种方式来处理。

#### (1) 使用 URL -> Block 解耦

简单来说就是将组件的调用代码放入 block 中，然后 URL 作为 key，block 作为 value，存入一个全局的 hash 容器，组件通过一个 URL （比如 "native/id=10/type=1" ）向 Mediator 发起请求，Mediator 找到对应的代码块执行。由此，解开了 Mediator 和目标组件的耦合（[见博客：蘑菇街 App 的组件化之路](https://limboy.me/tech/2016/03/10/mgj-components.html?nsukey=2J4Fq/9Yv25b7xU%2btUjEGUg995C4j3spQATg%2bw4DOzb0Ke53hCgoJJkV4aZpuIe3N5E2Ny4AmZ6RdQSgcNL8fsD9L/nZv63KFHK121kL7CMXGVe9Q3wXuL4GBZFFIrgWC%2br0qW4rQmjDdP9kZIwhxItDxkPIa1ulKkuNt60RqBgM5KID4WuYq51aYkxLijBw5rY4I3MjeLH8SizyIFMAlw==)）。

这种方案的缺陷很多：组件越多常驻内存越多；解析 URL 逻辑复杂；URL 无法表述具体语言相关的对象类型。所以这种方式并不适合组件化解耦。

#### (2) 使用 Protocol 解耦

阿里的 [BeeHive](https://github.com/alibaba/BeeHive) 是该方案的很好实践，笔者阅读了一下源码，它的大致工作原理如下：注册 Protocol 对应的组件，这个和上面说的 URL->Block 方式如出一辙，只不过这里是 Protocol-> Module ；组件申请访问时导入对应的 Protocol 通过 Mediator 获取到对应的组件对象。由于协议的表述能支持所有的对象类型，所以这种方式能基本解决组件间通信的需求。

BeeHive 注册组件有几种方式，一种是监听了动态链接时 image 二进制文件加载完成的回调，通过修改代码段的方式判断对应的模块进行注册；第二种是在 +load 方法里面注册；第三种是异步注册，但是这种方式存在一个问题，可能组件使用方准备使用组件的时候，这个组件还未注册成功。

BeeHive 还为组件设置了优先级的概念，它通过数组来保持优先级排序，在源码中能看到一些数组排序的逻辑，这就带来了相当多的高时间复杂度的运算。

所以，组件数量过多的话，会延长动态链接库的过程。

BeeHive 为了让每一个组件享有独自的 app 生命周期、3D touch 等功能，会将这些系统级的事件发送给每一个组件，且不谈大量的方法调用损耗，它必须让入口文件 AppDelegate 继承自 BeeHive 的 BHAppDelegate，笔者感觉侵入性过强，并且当开发者需要复写 AppDelegate 方法的时候，还要注意让super调用一下，可以说很不优雅了。

在基于协议的组件化方案中，组件使用方能直接拿到目标组件的实例，那么使用者可能对该实例进行修改，这可能会带来安全问题。

#### (3) 使用 Target-Action 解耦

Casa Taloyum 前辈的 [iOS应用架构谈 组件化方案](https://casatwy.com/iOS-Modulization.html) 为此做出了最佳实践。

Mediator 使用 Target-Action 来间接的调用目标组件，无需专门注册。组件维护者需要做一个 Mediator 的分类，通过硬编码调用目标组件，然后组件使用者只需要依赖这个分类就行了。封装的 Mediator 源码只有简单的 200+ 行代码，并且很易懂。这也让开发者能对组件化的实施更加有信心，不会因为基础设施的错误而束手无策。

#### 小总结

关于以上组件化的简单表述仅代表笔者的个人见解，由于笔者并没有真正的实施组件化，所以理解可能有误。

虽然笔者设计的 iOS 架构不会应用组件化，但是这给我们的架构设计带来了前瞻性的引导，这非常重要。

### 二、模块化思维划分文件

在团队开发中，项目发展到后期总是会出现某些文件或代码难以管理，出现这种情况的主要原因通常是项目开发过程中对文件的管理过于随意。

开发者应该尽量将所有代码文件归于模块，而不要出现模拟两可的文件。而笔者这里说的模块，是有具体意义的模块，比如图片处理模块、字体处理模块，而不是诸如 Public、Common 等无具体意义的代码文件。

试想，在多人开发中，当所有人都觉得有些代码不知道怎么归类的时候，就会往 Public 里面扔。当你某天想要整理一下这个 Public，会发现已经无从下手；或者当你需要迁移项目中的某个业务模块时，会附带迁移一些模块，当这个模块是有意义的（比如图片处理模块），你的迁移成本会非常低，但是当这个藕断丝连的模块是 Public 时，时间成本可能高于你的想象，估计你会将它完整的拷贝过去，而又对新项目造成了污染。

全局的公共文件是产生垃圾代码的源头。笔者认为几乎所有的代码都是可以归类为模块的。

大致梳理了一个文件分类，当然这个分类是灵活的，只是要分模块划分：

      - GeneralModules 放项目独有的通用配置模块（比如通用颜色模块、通用字体模块）  
      - ToolModules 放工具类模块（比如系统信息模块） 
      - PackageModules 放基于业务的一些封装（比如提示框模块、加载菊花模块） 
      - BusinessModules 放业务模块（比如购物车、个人中心）

具体里面放了些什么，可以查看笔者的 DEMO。

### 三、减少全局宏的使用

很多时候，过多的宏让项目很不整洁，每一个开发者都往全局文件添加宏，而往往只是一段简单的代码，笔者认为开发中应该尽量少使用宏，原因如下：

 - 宏在预编译阶段替换为实际代码，存在效率问题
 - 使用宏的地方可能只需要一块内存，但是宏替换过后开辟了多个（这种情况应该用常量替换宏）
 - 可能存在潜在的宏命名冲突
 - 宏包装过多的代码难以理解和调试
 - 代码迁移时需要处理全局的宏

实际上，非得使用宏的地方并非那么多，比如需要定义一个全局的导航栏字体方便使用，可以将通用字体的配置参数作为一个模块：

    @interface YBGeneralFont : NSObject
    /** 导航栏标题字体 */
    + (UIFont *)navigationBarTitleFont;
    @end

或者用常量来代替宏：

    .h
    FOUNDATION_EXTERN NSString * const kNotify_xxx; 
    //xxx通知 key.m
    NSString * const kNotify_xxx = @"kNotify_xxx";

这么做也便于转换思维，毕竟 swift 中是没有宏的。

### 四、去基类化设计

代码设计中，应该尽量避免基类的使用，也就是说，你不应该总是要求开发者去继承你的基类来做功能。使用基类将造成不可避免的耦合，为业务的长期发展带来阻碍（当然某些情况是可以使用基类的）。

其实使用基类就算了，若是将大量的业务逻辑放入基类中将是灾难的开端。试想，当项目新成员一来就看见成千上万行的基类代码TA作何感想？

另外一种场景，当需要将项目中的某个模块迁移到其他项目，或者需要将其他项目合并入当前项目，基类的合并将是一个非常头疼的问题，它藕断丝连的模块和代码会让你抓狂。
那么，类的工具方法应该放哪儿？对所有类的统一配置应该放哪儿？对封装模块的个性化定制应该怎么做？

#### 装饰模式

类的工具方法，按道理说可以提取为模块，但是有些场景可能显得不够简洁。

其实只要留意 iOS 官方的 API，你就不难发现装饰模式的大量应用，使用数个分类将大量的方法按照功能分类，会清晰且优雅：

    @interface UIViewController (YBGeneral)
    /** 基础配置 */
    - (void)YBGeneral_baseConfig;
    @end
    
    @interface UIViewController (YBGeneralBackItem)
    /** 配置通用系统导航栏返回按钮 */
    - (void)YBGeneral_configBackItem;
    /** 重写该方法以自定义系统导航栏返回按钮点击事件 */
    - (void)YBGeneral_clickBackItem:(UIBarButtonItem *)item;
    @end

不过要注意的时，定义分类的时候一定要加一个前缀标识以避免方法覆盖。

#### AOP

面向切面编程在 iOS 领域经典的应用就是利用 Runtime 去 Hook 方法：

```
+ (void)load {
    [self HQGeneralHook_exchangeImplementationsWithOriginSel:@selector(viewDidLoad) customSel:@selector(YBGeneralHook_viewDidLoad)];
}

+ (void)HQGeneralHook_exchangeImplementationsWithOriginSel:(SEL)originSel customSel:(SEL)customSel {
    Method origin = class_getInstanceMethod(self, originSel);
    Method custom = class_getInstanceMethod(self, customSel);
    if (origin && custom) {
        method_exchangeImplementations(origin, custom);
    }
}

- (void)HQGeneralHook_viewDidLoad {
    NSLog(@"进入：%@", self);
    [self HQGeneral_baseConfig];
    if (self.navigationController && [self.navigationController.viewControllers indexOfObject:self] != 0) {
        [self HQGeneral_configBackItem];
    }
    
    [self HQGeneralHook_viewDidLoad];
}

```

代码中统一配置了 UIViewController 的系统导航栏返回按钮，注意这里调用的业务配置方法都是定义在 UIViewController 的分类里面的。若有某些导航栏需要格外配置返回按钮的需求，可以拓展一个属性来控制。

面向协议设计模式

对于一些封装的组件，多考虑使用协议来个性化定制，继承作为最差方案，而非是首选方案。

定义一个遵守组件定制协议的属性是常用的解决方法：

    @property (nonatomic, strong) id<someprotocol>  strategy;</someprotocol>

不同的属性作为不同的策略，组件内部通过调用对应的协议方法实现个性化定制。而当使用者想要改变策略时，只需要更改这个属性就行了。面向协议设计模式结合策略模式是一个很好的实践。

### 五、MVC？MVP？MVVM？VIPER？

业务具体的架构模式是个让很多开发者头疼的问题，因为有时候能让复杂业务更清晰，有时候却因为胶水代码过多而臃肿。

实际上为什么要严格的遵守架构模式呢？为什么每一个业务模块的架构模式都要一模一样呢？

笔者认为正确的架构思路一定是根据业务来的，不同的模块，不同的业务线完全可以有不同的架构，只需要架构足够清晰不至于晦涩。

大致设计了一下架构的主旋律：

![1542853405354937.png](https://img-blog.csdnimg.cn/20181204110515777.png)

 - DataCenter 负责数据的获取、处理、缓存等。
 - Model 设计为“瘦” Model，便于复用和迁移；也考虑到数据源可能数量庞大，若 Model 设计得过于“胖”，会造成更多的内存占用。
 - View 负责数据的展示，可以根据业务情况权衡是否需要 ViewModel 处理界面逻辑。
 - ViewController 作为 DataCenter 和 View 的桥梁。

笔者设计的项目目前不会很复杂，多数情况上面的架构就已经够用，若某个页面功能过多，完全可以提取一些额外的模块，比如 DataCenter 处理过于复杂，那就把数据的处理和缓存提取出来：xxxDataProcesser、xxxDataCache。这些都是灵活的，只需要按照模块化的思维提取，ViewController 的代码相信也不会太多。

#### 关于响应式框架

Reactivecocoa 虽然强大，笔者以前也用过，不过它是一个重量级框架，学习成本有点高，可能会因为团队成员对其了解不足导致难以定位的错误。

而美团的 EasyReact 似乎是一个福音，笔者大概浏览了一下源码，质量确实很高，对性能方面的处理很精致，基于图论算法的处理也感觉很棒，项目侵入性也很小。不过缺点就是太新了，需要开发社区一定时间的验证，暂时笔者持观望态度。

### 结语

本文只是作者思考过后对一个项目架构的简单设计，还有很多部分需要完善和补充，具体细节也可能会按照具体情况修改。Demo 只是一个雏形，希望和各位读者朋友能有所交流。
