abstract class LayoutStates{}

class LayoutInitialState extends LayoutStates{}

class ChangeBottomNavigationIndexState extends LayoutStates{}

class GetUserDataSuccessState extends LayoutStates{}
class GetUserDataLoadingState extends LayoutStates{}
class FailedToGetUserDataState extends LayoutStates{
  String message;
  FailedToGetUserDataState(this.message);
}

class GetBannersSuccessState extends LayoutStates{}
class GetBannersLoadingState extends LayoutStates{}
class FailedToGetBannersState extends LayoutStates{}

class GetCategoriesSuccessState extends LayoutStates{}
class GetCategoriesLoadingState extends LayoutStates{}
class FailedToGetCategoriesState extends LayoutStates{}