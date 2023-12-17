class CloudStorageException implements Exception {
  const CloudStorageException();
}

// CRUD: Create, Read, Update, Delete
class CouldNotCreateUserException extends CloudStorageException {}

// R
class CouldNotGetAllUserException extends CloudStorageException {}

// U
class CouldNotUpdateGenreException extends CloudStorageException {}

class CouldNotUpdateFullNameException extends CloudStorageException {}

// D
class CouldNotDeleteUserException extends CloudStorageException {}
