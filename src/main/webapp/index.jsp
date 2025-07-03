<%@page import="java.util.List"%>
<%@page import="dao.ProgramadorDAO"%>
<%@page import="modelo.Programador"%>
<%
    if (session.getAttribute("logueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String nombreUsuario = (String) session.getAttribute("nombre");
    Integer idUsuario = (Integer) session.getAttribute("id");

    ProgramadorDAO dao = new ProgramadorDAO();
    List<Programador> lista = null;

    String mensajeExito = (String) session.getAttribute("mensajeExito");
    String mensajeError = (String) session.getAttribute("mensajeError");
    session.removeAttribute("mensajeExito");
    session.removeAttribute("mensajeError");

    Programador programadorAEditar = null;
    String formAction = "crear";
    String buttonText = "Crear Programador";

    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int idEditar = Integer.parseInt(idParam);
            programadorAEditar = dao.obtenerPorId(idEditar);
            if (programadorAEditar != null) {
                formAction = "actualizar";
                buttonText = "Guardar Cambios";
            } else {
                session.setAttribute("mensajeError", "Programador no encontrado para editar.");
                response.sendRedirect("index.jsp");
                return;
            }
        } catch (NumberFormatException e) {
            session.setAttribute("mensajeError", "ID de programador no válido para editar.");
            response.sendRedirect("index.jsp");
            return;
        } catch (Exception e) {
            session.setAttribute("mensajeError", "Error al cargar programador para editar: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("index.jsp");
            return;
        }
    }

    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("accion") != null) {
        String accion = request.getParameter("accion");
        try {
            Programador p = new Programador();

            if ("actualizar".equals(accion)) {
                String idForm = request.getParameter("idProgramador");
                if (idForm != null && !idForm.isEmpty()) {
                    p.setId(Integer.parseInt(idForm));
                } else {
                    throw new IllegalArgumentException("ID del programador es requerido para actualizar.");
                }
            }

            p.setNombre(request.getParameter("nombre"));
            p.setLenguajeD(request.getParameter("lenguajeD"));
            try {
                p.setLenguajeC(Integer.parseInt(request.getParameter("lenguajeC")));
            } catch (NumberFormatException nfe) {
                session.setAttribute("mensajeError", "Error: La cantidad de lenguajes debe ser un número válido.");
                response.sendRedirect("index.jsp");
                return;
            }

            p.setPassword(request.getParameter("password"));
            p.setEstudiante(request.getParameter("estudiante") != null ? 1 : 0);

            if ("crear".equals(accion)) {
                dao.insertar(p);
                session.setAttribute("mensajeExito", "Programador creado exitosamente.");
            } else if ("actualizar".equals(accion)) {
                dao.actualizar(p);
                session.setAttribute("mensajeExito", "Programador actualizado exitosamente.");
            }

            response.sendRedirect("index.jsp");
            return;
        } catch (Exception e) {
            session.setAttribute("mensajeError", "Error al procesar programador: " + e.getMessage());
            e.printStackTrace();
        }
    }

    lista = dao.listarTodos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Programadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-dark text-light">
    <div class="login-container">
        <div class="login-box p-4 rounded shadow-lg">

            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <h1 class="h3 text-light mb-0">Programadores Registrados</h1>

                <div class="d-flex align-items-center">
                    <a href="index.jsp?id=<%= idUsuario != null ? idUsuario : "" %>" class="btn btn-link text-info text-decoration-none p-0 me-2" title="Editar tu perfil">
                        <i class="fas fa-user me-1"></i><%= nombreUsuario != null ? nombreUsuario : "Usuario" %>
                    </a>
                    <a href="cierreSesion.jsp" class="btn btn-danger btn-sm" title="Cerrar sesión">
                        <i class="fas fa-sign-out-alt me-1"></i>Log out
                    </a>
                </div>
            </div>

            <% if (mensajeError != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= mensajeError %>
                </div>
            <% } %>
            <% if (mensajeExito != null) { %>
                <div class="alert alert-success" role="alert">
                    <%= mensajeExito %>
                </div>
            <% } %>

            <div class="row">
                <div class="col-md-4">
                    <h4 class="text-light mt-0 mb-3"><%= formAction.equals("crear") ? "Crear Nuevo Programador" : "Editar Programador" %></h4>
                    <form method="post" action="index.jsp">
                        <input type="hidden" name="accion" value="<%= formAction %>">
                        <% if (programadorAEditar != null) { %>
                            <input type="hidden" name="idProgramador" value="<%= programadorAEditar.getId() %>">
                        <% } %>
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre:</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required
                                   value="<%= programadorAEditar != null ? programadorAEditar.getNombre() : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="lenguajeD" class="form-label">Lenguaje Dominante:</label>
                            <input type="text" class="form-control" id="lenguajeD" name="lenguajeD" required
                                   value="<%= programadorAEditar != null ? programadorAEditar.getLenguajeD() : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="lenguajeC" class="form-label">Cantidad Lenguajes:</label>
                            <input type="number" class="form-control" id="lenguajeC" name="lenguajeC" required min="0"
                                   value="<%= programadorAEditar != null ? programadorAEditar.getLenguajeC() : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña:</label>
                            <input type="password" class="form-control" id="password" name="password" required
                                   value="<%= programadorAEditar != null ? programadorAEditar.getPassword() : "" %>">
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="estudiante" name="estudiante" value="1"
                                   <%= programadorAEditar != null && programadorAEditar.getEstudiante() == 1 ? "checked" : "" %>>
                            <label class="form-check-label" for="estudiante">
                                Es Estudiante
                            </label>
                        </div>
                        <button type="submit" class="btn btn-primary"><%= buttonText %></button>
                        <% if (programadorAEditar != null) { %>
                            <a href="index.jsp" class="btn btn-secondary ms-2">Cancelar Edición</a>
                        <% } %>
                    </form>
                </div>

                <div class="col-md-8">
                    <h4 class="text-light mt-0 mb-3">Empleados</h4>
                    <div class="table-responsive">
                        <table class="table table-dark table-striped table-hover table-bordered caption-top">
                            <caption>Lista de programadores registrados</caption>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Lenguaje Dominante</th>
                                    <th>Cantidad</th>
                                    <th>Estudiante</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (lista != null && !lista.isEmpty()) {
                                    for (Programador p : lista) {
                                        if (!"admin".equalsIgnoreCase(p.getNombre())) { %>
                                            <tr>
                                                <td><%= p.getId() %></td>
                                                <td><%= p.getNombre() %></td>
                                                <td><%= p.getLenguajeD() %></td>
                                                <td><%= p.getLenguajeC() > 1 ? "muchos" : p.getLenguajeC() %></td> 
                                                <td><%= p.getEstudiante() == 1 ? "Sí" : "No" %></td>
                                                <td>
                                                    <a href="index.jsp?id=<%= p.getId() %>" class="btn btn-warning btn-sm me-2" title="Editar este programador">
                                                        <i class="fas fa-pencil-alt"></i>
                                                    </a>
                                                    <form method="post" action="borrar.jsp" style="display:inline;">
                                                        <input type="hidden" name="id" value="<%= p.getId() %>">
                                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro que deseas eliminar este programador?')" title="Eliminar este programador">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                <%      }
                                    }
                                } else { %>
                                    <tr>
                                        <td colspan="6" class="text-center">No hay programadores registrados.</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
