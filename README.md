# dudv_base

```sh
flutter pub publish
```
```dart
Expanded(
              child: GroupedListView<CubeMessage, String>(
                elements: _presenter.listMsg,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                onRefresh: _presenter.onRefresh,
                reverse: true,
                order: GroupedListOrder.DESC,
                physics: AlwaysScrollableScrollPhysics(),
                controller: _presenter.controller,
                groupBy: (CubeMessage element) => DateFormat.yMMMd().format(
                    DateTime.fromMillisecondsSinceEpoch(
                        element.dateSent * 1000)),
                groupHeaderBuilder: _presenter.groupHeaderBuilder,
                itemBuilder: _presenter.itemBuilder,
              ),
            ),


  @override
  Widget itemBuild(BuildContext context, int index) {
    print('_autoMsg $_autoMsg');
    if (index < list.length) {
      CubeMessage message = list[index];
      return ItemMessageView(
        message: message,
        cubeUser: ccUseridInt,
        cubeDialog: cubeDialog,
        choiceAction: choiceAction,
        markAsReadIfNeed: markAsReadIfNeed,
      );
    }
    return Visibility(
      visible: _apiClient.hashNextPage,
      child: loadingView(),
    );
  }

  Widget groupHeaderBuilder(CubeMessage element) {
    return ItemTimeView(
      model: element,
    );
  }

````