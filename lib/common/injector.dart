import 'package:injector/injector.dart';
import 'package:list_staff_members/database/db_adapter.dart';
import 'package:list_staff_members/database/gateaways/gateaways.dart';
import 'package:list_staff_members/state/childrent_bloc.dart';
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

  injector.registerSingleton<ChildrenBloc>((injector) {
    return ChildrenBloc(
      childrenGateway: injector.getDependency<ChildrenGateway>(),
    );
  });

  injector.registerSingleton<ParentBloc>((injector) {
    return ParentBloc(
      parentGateway: injector.getDependency<ParentGateway>(),
      childrenGateway: injector.getDependency<ChildrenGateway>(),
    );
  });
}

void closeGlobalBlocs() {
  Injector injector = Injector.appInstance;
  injector.getDependency<ChildrenBloc>().close();
  injector.getDependency<ParentBloc>().close();
}
