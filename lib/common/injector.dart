import 'package:injector/injector.dart';
import 'package:list_staff_members/database/db_adapter.dart';
import 'package:list_staff_members/database/gateaways/gateaways.dart';
import 'package:list_staff_members/state/parent_bloc.dart';

Future<void> setupInjector() async {
  Injector injector = Injector.appInstance;

  injector.registerSingleton<DbAdapter>((_) => DbAdapter());

  injector.registerSingleton<ChildrenGateway>((Injector injector) {
    return ChildrenGateway(db: injector.getDependency<DbAdapter>());
  });

  injector.registerSingleton<ParentGateway>((Injector injector) {
    return ParentGateway(
      db: injector.getDependency<DbAdapter>(),
    );
  });

  injector.registerSingleton<ParentBloc>((injector) {
    return ParentBloc(
      parentGateway: injector.getDependency<ParentGateway>(),
      childrenGateway: injector.getDependency<ChildrenGateway>(),
    );
  });
  // injector.registerSingleton<ResultsGateway>((Injector injector) {
  //   return ResultsGateway(db: injector.getDependency<DbAdapter>());
  // });
  // injector.registerSingleton<SettingsGateway>((Injector injector) {
  //   return SettingsGateway(db: injector.getDependency<DbAdapter>());
  // });
  // injector.registerSingleton<SystemGateway>((Injector injector) {
  //   return SystemGateway(db: injector.getDependency<DbAdapter>());
  // });

  // injector.registerSingleton<AnalysisBloc>((Injector injector) {
  //   return AnalysisBloc(
  //     questionsGateway: injector.getDependency<QuestionsGateway>(),
  //     resultsGateway: injector.getDependency<ResultsGateway>()
  //   );
  // });
  // injector.registerSingleton<DiaryBloc>((Injector injector) {
  //   return DiaryBloc(resultsGateway: injector.getDependency<ResultsGateway>());
  // });
  // injector.registerSingleton<DynamicsBloc>((Injector injector) {
  //   return DynamicsBloc(
  //     questionsGateway: injector.getDependency<QuestionsGateway>(),
  //     resultsGateway: injector.getDependency<ResultsGateway>()
  //   );
  // });
  // injector.registerSingleton<QuestionsBloc>((Injector injector) {
  //   return QuestionsBloc(questionsGateway: injector.getDependency<QuestionsGateway>());
  // });
  // injector.registerSingleton<ResultsBloc>((Injector injector) {
  //   return ResultsBloc(resultsGateway: injector.getDependency<ResultsGateway>());
  // });

  // injector.registerSingleton<SystemBloc>((Injector injector) {
  //   return SystemBloc(
  //     questionsGateway: injector.getDependency<QuestionsGateway>(),
  //     systemGateway: injector.getDependency<SystemGateway>()
  //   );
  // });

  // injector.registerSingleton<NotificationBloc>((_) => NotificationBloc());
  // await injector.getDependency<NotificationBloc>().initializeNotification();
  
  // injector.registerSingleton<SettingsBloc>((Injector injector) {
  //   return SettingsBloc(
  //     settingsGateway: injector.getDependency<SettingsGateway>(),
  //     notification: injector.getDependency<NotificationBloc>().notification,
  //     systemGateway: injector.getDependency<SystemGateway>()
  //   );
  // });
}

void closeGlobalBlocs() {
  Injector injector = Injector.appInstance;
  // injector.getDependency<ChildrenGateway>().close();
  // injector.getDependency<ParentGate>().close();
}
