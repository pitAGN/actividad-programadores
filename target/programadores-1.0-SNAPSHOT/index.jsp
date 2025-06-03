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
  <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
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
            <h4>nombreProgramador</h4>
            <form method="post" action="crear.jsp">
                <div class="mb-3">
                    <input type="text" class="form-control" name="nombre" placeholder="Andres Gonzalez" required>
                </div>
                <h6>lenguaje que más domina</h6>
                <div class="mb-3">
                    <input type="text" class="form-control" name="lenguajeD" placeholder="java" required>
                </div>
                <h6>lenguajes que conoce</h6>
                <div class="mb-3">
                    <input type="number" class="form-control" name="lenguajeC" placeholder="2" required>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="estudiante">
                    <label class="form-check-label" for="estudiante">Estudiante</label>
                </div>
                <button type="submit" class="btn btn-outline-primary" name="Guardar">Guardar</button>
            </form>
        </div>

        <!-- TABLA -->
        <div class="col-md-8">
            <h2>Programadores registrados</h2>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>nombre</th>
                        <th>lenguaje que domina</th>
                        <th>lenguajes que conoce</th>
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
