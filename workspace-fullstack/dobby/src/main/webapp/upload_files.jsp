<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.io.*" %>

<%
    boolean isMultipart = request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/");
    if (isMultipart) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            List<FileItem> formItems = upload.parseRequest(request);
            if (formItems != null && !formItems.isEmpty()) {
                for (FileItem item : formItems) {
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        item.write(storeFile);
                        String fileUrl = request.getContextPath() + "/uploads/" + fileName;
                        out.println("Upload has been done successfully! <br>");
                        out.println("File URL: <a href='" + fileUrl + "'>" + fileUrl + "</a><br>");
                        out.println("<video width='320' height='240' controls>");
                        out.println("<source src='" + fileUrl + "' type='video/mp4'>");
                        out.println("Your browser does not support the video tag.");
                        out.println("</video>");
                    } else {
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString();
                        out.println("Field: " + fieldName + ", Value: " + fieldValue + "<br/>");
                    }
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Error parsing upload request", e);
        } catch (Exception e) {
            throw new ServletException("Error saving uploaded file", e);
        }
    } else {
        out.println("Form is not multipart/form-data");
    }
%>
