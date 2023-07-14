import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> openConnection() async {
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'anvolapp',
    password: 'appanvol',
    db: 'anvolapp',
  );

  final connection = await MySqlConnection.connect(settings);
  return connection;
}

Future<void> fetchAccounts() async {
  final connection = await openConnection();

  // Execute the SELECT query
  final results = await connection.query('SELECT * FROM users');

  // Process the results
  for (var row in results) {
    // Access the column values using row[columnName]
    final id = row['id'];
    final name = row['name'];
    final email = row['email'];

    // Do something with the data
    print('User: $name, Email: $email');
  }

  // Close the database connection
  await connection.close();
}
