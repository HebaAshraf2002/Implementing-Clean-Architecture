# Clean Architecture: Presentation Layer Logic with Dependency Injection

## 📌 Overview
This project follows the **Clean Architecture** pattern in a Flutter application, ensuring separation of concerns and maintainability. The task involves setting up the project with a structured architecture, implementing a use case for fetching a list of tasks, and managing dependencies using the **GetIt** dependency injection package. Additionally, **Provider** is used for state management in the presentation layer.

## 🛠 What the Code Does
- **Implements Clean Architecture** by structuring the project into three main layers:
  - **Data Layer**: Handles API calls and data models.
  - **Domain Layer**: Contains business logic and use cases.
  - **Presentation Layer**: Manages UI and state.
- **Fetches a list of tasks** from an API using an HTTP client.
- **Uses Dependency Injection (DI)** with GetIt to register and provide necessary dependencies.
- **Implements state management** with Provider to manage and update UI state based on data changes.
- **Displays fetched tasks in a UI screen** using a `ListView`.

## ⚙️ How the Code Works
### 1️⃣ Setting Up Dependency Injection
- The **GetIt** package is used to register dependencies in a service locator.
- Dependencies like the `TaskRepositoryImpl` and `TaskViewModel` are registered and injected where needed.

#### Example:
```dart
final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => TaskRepositoryImpl(http.Client()));
  getIt.registerFactory(() => TaskViewModel(getIt<TaskRepositoryImpl>()));
}
```

### 2️⃣ Implementing State Management
- The `TaskViewModel` extends `ChangeNotifier` and is used to manage UI state.
- It fetches the list of tasks and updates the UI when data is loaded.

#### Example:
```dart
class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository;
  List<Task> tasks = [];
  bool isLoading = false;

  TaskViewModel(this._repository);

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();
    tasks = await _repository.fetchTasks();
    isLoading = false;
    notifyListeners();
  }
}
```

### 3️⃣ Fetching Data from API
- The `TaskRepositoryImpl` implements `TaskRepository` and fetches data using the `http` package.
- JSON data is converted into a list of `Task` objects.

#### Example:
```dart
class TaskRepositoryImpl implements TaskRepository {
  final http.Client client;
  TaskRepositoryImpl(this.client);

  @override
  Future<List<Task>> fetchTasks() async {
    final response = await client.get(Uri.parse('https://api.example.com/tasks'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
```

### 4️⃣ Displaying Data in the UI
- **ChangeNotifierProvider** is used to provide `TaskViewModel` to the UI.
- **Consumer** listens for state changes and rebuilds the widget accordingly.
- A `ListView.builder` displays the fetched tasks.

#### Example:
```dart
class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<TaskViewModel>()..loadTasks(),
      child: Scaffold(
        appBar: AppBar(title: Text('Tasks')),
        body: Consumer<TaskViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: viewModel.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(viewModel.tasks[index].title));
              },
            );
          },
        ),
      ),
    );
  }
}
```
