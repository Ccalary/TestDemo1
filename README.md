# TestDemo1

>各种框架的收集与简单封装使用，还有一些基本的工具类的收集

## 包含框架
* [Realm](https://github.com/realm/realm-cocoa)数据库的简单使用(已移除)
* [MJRefresh](https://github.com/CoderMJLee/MJRefresh)的简单封装
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD)的简单封装,更改了显示的颜色
* [POP](https://github.com/facebook/pop) facebook开源的动画框架
* [MJExtension](https://github.com/CoderMJLee/MJExtension)model转化使用

## 全局宏定义
* 屏幕宽高，适配比列, Debug信息,颜色RGB和十六进制（0xffffff）,字体大小,

## 不常用控件学习
* UIStepper 实现加减—＋
* UIToolBar 简单使用
* UIImageView 实现gif动画
* UIRefreshControl 系统刷新(只有下拉刷新)
* Quartz 2D 图片的简单绘制

## 2017.5.25
* UITableView：多选编辑处理
* CountingLabel三方：数字滚动，CADisplayLink的简单使用

## 2017.5.27
* POP的使用几种使用，心跳动画，自定义动画等
* HHPopButton 基于Pop的button封装，点击后有动画效果。
* NSDictionary添加分类，解决打印不是中文的问题
* 重写自定义model类中的description方法，实现具体信息的打印

## 2017.6.1
* GCD的简单使用
* 拖动，摇一摇，截屏实现
* 圆形进度条

## 2017.6.8
* Realm数据库的使用，从网络获取省市区三级地址用MJExtension进行Model类映射，对数据进行了数据库存储，查询等操作。
  更多使用详见[文档](https://realm.io/docs/objc/latest/)

## 2017.6.12
* Realm数据库的使用，对映射进行了优化，使用Realm提供的数据类型进行直接的映射和使用
* 贝赛尔曲线在CASharpLayer绘画的学习，直线，任意矩形状，圆，二次曲线，三次曲线，绘制路径等
* 移动动画，根据贝赛尔路径移动，loading加载动画


## 2017.6.16
* CAEmitterLayer 粒子动画的学习

## 2017.7.25
* 类似直播的321倒计时

## 2017.11.21
* 局部跑马灯HHRunLabelView
* 倒计时按钮（发送验证码）
* 封装UIAlertController-HHAlertController
* 弹出菜单（加三角的）HHPopSelectView

## 2018.1.30
* 数据持久化，归档解档
* 移除Realm

## 2018.4.4
* Iconfont的使用

## 2018.4.27
* 增加对转场动画的封装，实现UIView+MCTransition

## 2018.5.3
* Quart2D绘图，水印，圆形截取，加边框，截屏，刮涂层，自定义截取范围

## 2018.5.19
* fastlane 自动打包
* SDWebImage 源码解读，自己实现简单的缓存
* blokc 基础
