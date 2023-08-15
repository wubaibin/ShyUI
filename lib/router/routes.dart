part of 'pages.dart';

abstract class AppRoutes {
  /// 初始页
  static const mainPage = '/';

  /// 扫码
  static const scanCodePage = '/scanCode';

  /// 登录
  static const loginPage = '/login';

  /// 首页
  static const homePage = '/home';

  /// 工作台
  static const workbenchPage = '/workbench';

  // ---
  /// 订单
  static const orderPage = '/order';

  /// 订单
  static const orderDetailPage = '/detail';

  /// 提现
  static const withdrawDepositPage = '/withdrawDeposit';

  /// 提现记录
  static const withdrawDepositRecordPage = '/record';

  /// 收益提现
  static const profitWithdrawalPage = '/profitWithdrawal';

  // ---
  /// 我的
  static const userPage = '/user';

  /// 重置密码
  static const resetPasswordsPage = '/resetPasswords';

  /// 换电记录
  static const replaceBatteryRecordPage = '/replaceBatteryRecord';

  // ---
  /// 退订
  static const unsubscribePage = '/unsubscribe';

  /// 退订申请
  static const unsubscribeListPage = '/list';

  /// 退订处理
  static const unsubscribeDetailPage = '/detail';

  /// 退订记录
  static const unsubscribeRecordPage = '/record';

  // ---
  /// 更换设备
  static const deviceExchangePage = '/deviceExchange';

  /// 更换设备列表
  static const deviceExchangeListPage = '/list';

  /// 变更记录
  static const deviceExchangeRecordPage = '/record';

  /// 修正绑定关系
  static const deviceExchangeBindPage = '/bind';

  /// ---
  /// 电池
  static const batteryPage = '/battery';

  /// 电池详情
  static const batteryDetailPage = '/detail';

  /// 电池告警
  static const batteryReportPage = '/report';

  /// 换电柜
  static const batteryBoxPage = '/batteryBox';

  /// 换电柜详情
  static const batteryBoxDetailPage = '/detail';

  /// 车辆
  static const bikePage = '/bike';

  /// 车辆详情
  static const bikeDetailPage = '/detail';

  /// 操作日志
  static const operationRecordPage = '/operationRecord';

  /// 骑行轨迹
  static const gpsLogPage = '/gpsLog';

  /// ---
  /// 工单列表
  static const workOrderListPage = '/workOrder';

  /// 创建工单
  static const workOrderCreatePage = '/create';

  /// 接单
  static const workOrderGetPage = '/get';

  /// 处理工单
  static const workOrderDisposePage = '/dispose';

  /// 派单
  static const workOrderSetPage = '/set';

  /// 拒单记录
  static const refuseRecordPage = '/refuseRecord';

  /// 返厂维修
  static const workOrderBackFactoryPage = '/backFactory';

  /// ---
  /// 调度单列表
  static const dispatchPage = '/dispatch';

  /// 批量调度
  static const dispatchBatchPage = '/batch';

  /// 申请调度
  static const dispatchApplyPage = '/apply';

  /// 出库确认
  static const outboundVerifyPage = '/outboundVerify';

  /// 入库确认
  static const inboundVerifyPage = '/inboundVerify';

  /// 添加设备
  static const addDevicePage = '/addDevice';

  /// 设备配送
  static const deviceDispatchPage = '/deviceDispatch';

  /// 调度单详情
  static const dispatchDetailPage = '/detail';

  /// ---
  /// 门店管理
  static const outletPage = '/outlet';

  /// 门店详情
  static const outletDetailPage = '/detail';

  /// 选择门店/换电站
  static const selectOutletPage = '/select';

  /// ---
  /// 设备告警
  static const deviceWarnPage = '/deviceWarn';

  /// 设备告警
  static const deviceWarnListPage = '/list';

  /// 设备告警详情
  static const deviceWarnDetailPage = '/detail';
}
