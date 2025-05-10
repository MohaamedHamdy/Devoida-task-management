**Setup Instructions:**
Prerequisites
Flutter SDK
MySQL
Python with FastAPI and Uvicorn

Steps
1- Clone the repo
2- flutter pub get
3- flutter run
Set up Python virtual environment:
1- python -m venv venv
2- source venv/bin/activate 
3- pip install -r requirements.txt
4- uvicorn app.main:app --reload




**Decision-Making Reports**
1- Backend choice
I chose FastAPI for the backend due to its speed, ease of use, and automatic Swagger documentation generation. As someone without prior experience with FastAPI, Flask, or Laravel, FastAPI stood out because it allows rapid development and integrates easily with other services.

Key reasons for the choice include:
1- Speed: FastAPI is known for its high performance, making it ideal for handling many requests quickly.
2- Ease of Use: Its simple and intuitive design makes it easy to learn and implement.
3- Swagger Documentation: FastAPI automatically generates interactive API documentation, which is helpful for testing and collaboration with front-end developers.
4- Scalability and Flexibility: FastAPI supports asynchronous programming, allowing the backend to scale efficiently as demand increases.

In summary, FastAPI is a great fit for quick development, performance, and ease of use, especially when starting with new technologies.

2- Database choice
I chose MySQL due to its reliability, scalability, and strong community support. It's ideal for structured data and complex queries, offering ACID compliance for data integrity.

Comparison:
Firebase Firestore: NoSQL, great for scalability but less suited for complex relational queries.
Supabase (PostgreSQL): Powerful, but I preferred MySQL for its simplicity and speed for my needs.
MySQL's proven performance and ease of use made it the best choice for my project.

3- Storage (for Attachments):
Even though I didn't store attachments in this project, for scenarios involving file storage, Amazon S3 would be a top choice due to its scalability, high availability, and wide adoption in production environments.

Comparison:
Firebase Storage: Easy to integrate with Firebase services, good for real-time applications, but may not offer as much flexibility and control as Amazon S3.
Amazon S3: Highly scalable, secure, and reliable for large-scale file storage with robust features, but more setup might be required compared to Firebase.
Supabase Storage: Great for seamless integration with Supabase, but may not have as many features or as mature a service as S3.
Amazon S3 would be the preferred option for large, secure, and scalable file storage solutions.

4- Implementation Plan:
1. Database Structure:

MySQL: The backend is connected to a MySQL database where all data (e.g., user information, workspaces) is stored in structured tables.
Tables: Relevant tables like users, workspaces, and attachments are created. Relationships are defined using foreign keys (e.g., each workspace belongs to a user).

2. Storage:

File Storage: Though not implemented in this case, file attachments can be stored in Amazon S3 for scalability. Each file would be stored with a unique identifier (e.g., a UUID or the workspace ID).

Connection to Backend: Files would be uploaded to S3 using pre-signed URLs. The backend API would manage the interaction between the app and S3.

3. App Connection:

Backend: The FastAPI backend serves as the bridge between the app and the database/storage. It handles user requests, queries the database, and interacts with the storage service (e.g., fetching file URLs or saving workspace data).
Frontend (Flutter): The app communicates with the FastAPI backend via HTTP requests. Data is fetched or sent using REST APIs.


--------------------------------------------------------------------------------------------------------------------
**Technical Questions**

1. Backend Architecture:
To scale the backend for 1 million users:

Horizontal Scaling: Implement a microservices architecture to break down the monolithic system into smaller services (e.g., user service, workspace service, etc.). This allows each service to scale independently.
Load Balancing: Use load balancers to distribute traffic evenly across servers.
Caching: Implement caching mechanisms (e.g., Redis or Memcached) to reduce database load and speed up frequently requested data.

This architecture ensures that as user growth increases, the backend can handle high loads while maintaining performance and availability.

2. Authentication Strategy:
Token-based Authentication: Use JWT (JSON Web Tokens) for secure user authentication. The frontend sends a request with the token in the header, and the backend verifies the token to authenticate the user.
Token Expiration & Refresh Flow: JWT tokens have a short expiration time (e.g., 15 minutes). When a token expires, the frontend requests a new token using a refresh token, which is stored securely (e.g., in HTTP-only cookies or secure storage).
The backend verifies the refresh token and issues a new JWT token for the user.

This ensures the user is not logged out frequently while maintaining security.

3. Database Modeling:
Users Table: Stores user information (e.g., ID, email, password hash).
Workspaces Table: Stores workspace data (e.g., workspace ID, name, description, user ID as a foreign key for the creator).
Workspace Members: A workspace has multiple members, which can be represented by a many-to-many relationship between users and workspaces. This would require a WorkspaceMembers table to store the relationships.
Boards Table: Stores boards within workspaces (e.g., board ID, name, workspace ID as a foreign key).
Tasks Table: Stores tasks within boards (e.g., task ID, description, board ID as a foreign key, user ID for assigned user).

Relationships:

A user can have many workspaces.
A workspace can have many boards.
A board can have many tasks.
Users can be assigned to tasks (via a foreign key to the user table).
A workspace can have many members, which is represented by a many-to-many relationship through the WorkspaceMembers table.

This setup ensures smooth relationships between entities while keeping data normalized.

State Management (Frontend):
Provider: Simple and lightweight, with built-in support for managing app state in a reactive way. Suitable for small to medium projects.

Riverpod: More advanced than Provider, providing better testing support and allowing for global and scoped state management. Offers features like caching, scoped providers, and improved performance.

BLoC: Best suited for large-scale applications, it follows the unidirectional data flow pattern. It’s more complex but great for apps with intricate state management needs.

Cubit: A simpler alternative to BLoC, Cubit is part of the flutter_bloc package. It provides a lightweight and reactive approach to managing state, with less boilerplate than BLoC. It’s ideal for projects that require scalable state management without the complexity of full BLoC architecture.

Preferred Choice - Cubit:
For this project, Cubit is preferred. It offers the simplicity of managing state without the complexity of BLoC while still being highly scalable. 
Cubit is ideal for handling state in an easy-to-understand way, with minimal boilerplate code. 
It is highly reactive and works well for both simple and more complex state management needs. 
Its ease of use and flexibility make it an excellent choice for this project, particularly as it allows for quick implementation and easier maintenance.

5. Offline Handling:
Local Storage: Use SQLite (for mobile apps) or IndexedDB (for web) to store app data locally. This allows users to interact with the app offline.
Offline-first Approach: Ensure the app can function without an internet connection by designing it to prioritize local storage for data and sync when connectivity is available.

This approach ensures the app is usable even in the absence of internet access and automatically syncs when possible.
