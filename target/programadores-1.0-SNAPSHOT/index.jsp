<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Programadores</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;
%>

<div class="container mt-5">
    <div class="row">
        <!-- FORMULARIO -->
        <div class="col-md-4">
            <h4>Registrar Programador</h4>
            <form method="post" action="crear.jsp">
                <div class="mb-3">
                    <label>Nombre</label>
                    <input type="text" class="form-control" name="nombre" placeholder="Andres Gonzalez" required>
                </div>
                <div class="mb-3">
                    <label>Lenguaje que más domina</label>
                    <input type="text" class="form-control" name="lenguajeD" placeholder="Java" required>
                </div>
                <div class="mb-3">
                    <label>Cantidad de lenguajes que conoce</label>
                    <input type="number" class="form-control" name="lenguajeC" placeholder="2" required>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="estudiante" name="estudiante" value="1">
                    <label class="form-check-label" for="estudiante">Estudiante</label>
                </div>
                <button type="submit" class="btn btn-outline-primary" name="Guardar">Guardar</button>
            </form>
        </div>

        <!-- TABLA -->
        <div class="col-md-8">
            <h2>Programadores Registrados</h2>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Lenguaje que domina</th>
                        <th>Cantidad que conoce</th>
                        <th>Estudiante</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/programadores", "root", "");
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM tblprogramadores");

                    while(rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("id_programador") %></td>
                        <td><%= rs.getString("nombre") %></td>
                        <td><%= rs.getString("lenguajeD") %></td>
                        <td><%= rs.getInt("lenguajeC") > 1 ? "muchos" : rs.getInt("lenguajeC") %></td>
                        <td><%= rs.getInt("estudiante") == 1 ? "Sí" : "No" %></td>
                    </tr>
                <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
