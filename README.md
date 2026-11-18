# Shortest Path App
An app for calculating the shortest path between two points using A-star algorithm.

Built without third-party packages

## Getting started
 
Requirements: Flutter 3.47.9 (see `flutter --version`)
 
```bash
git clone https://github.com/Kanada3000/shortest_path_app.git
cd shortest_path_app
flutter pub get
flutter run
```
 
Default API URL: `https://flutter.webspark.dev/flutter/api`

## Features
- Enter an URL (with supported GET params) with validation
- Fetch tasks from API
- Calculate the shortest path for tasks
- Send results to Api for verification
- View the list of results
- Preview the grid of results with such colors:
  - Start point: `#64FFDA`
  - End point: `#009688`
  - Blocked tile: `#000000`
  - Path tile: `#4CAF50`
  - Empty tile: `#FFFFFF`
  
## Architecture
 
The project follows **Clean Architecture**, split by features:
 
```
lib/
  core/
    utils/             # URL validation
  features/
    home/
      data/            # DTOs, mappers, remote data source, repository implementation
      domain/          # entities, repository interface, pathfinding algorithm
      presentation/    # home screen, URL form, process screen
    results/
      presentation/    # results list, preview screen
```

## Screenshots

<p>
  <img src="docs/screenshots/home.png" width="200" alt="Home screen">
  <img src="docs/screenshots/process_calculating.png" width="200" alt="Process screen: calculating">
  <img src="docs/screenshots/process_checking.png" width="200" alt="Process screen: checking">
  <img src="docs/screenshots/results.png" width="200" alt="Results screen">
  <img src="docs/screenshots/preview.png" width="200" alt="Preview screen">
</p>
