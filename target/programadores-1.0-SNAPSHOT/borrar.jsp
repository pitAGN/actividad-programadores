<%@ page import="dao.ProgramadorDAO" %>
<%
    String error = null;

    try {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            throw new IllegalArgumentException("ID de programador no proporcionado.");
        }

        int id = Integer.parseInt(idParam);
        ProgramadorDAO dao = new ProgramadorDAO();
        dao.eliminar(id);

        response.sendRedirect("index.jsp");
        return;

    } catch (NumberFormatException e) {
        error = "Error: El ID proporcionado no es un número válido.";
        out.println("Error en borrar.jsp (NumberFormatException): " + e.getMessage());
        e.printStackTrace();
    } catch (IllegalArgumentException e) {
        error = "Error: " + e.getMessage();
        out.println("Error en borrar.jsp (IllegalArgumentException): " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        error = "Error al intentar eliminar el programador: " + e.getMessage();
        out.println("Error en borrar.jsp (General Exception): " + e.getMessage());
        e.printStackTrace();
    }

    if (error != null) {
        session.setAttribute("mensajeError", error);
        response.sendRedirect("index.jsp");
    }
%>
