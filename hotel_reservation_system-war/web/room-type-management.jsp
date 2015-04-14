<%@page import="java.math.BigDecimal"%>
<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    RoomTypeSessionBeanRemote rsb = (RoomTypeSessionBeanRemote)ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
    AmenitySessionBeanRemote asb = (AmenitySessionBeanRemote)ctx.lookup(AmenitySessionBeanRemote.class.getName());
    if (rsb == null || asb == null) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    int rid = 0;
    RoomType room = null;
    if (request.getParameter("rid") != null) {
        try {
            rid = Integer.parseInt(request.getParameter("rid"));
            room = (RoomType)rsb.getRoomTypeDetails(rid);
        } catch (Exception e) {
            rid = 0;
        }
    }
    if (request.getMethod().compareToIgnoreCase("post") == 0) {
        Boolean create = false;
        if (room == null) {
            create = true;
            room = new RoomType();
        }
        if (request.getParameter("input_room_type") != null && request.getParameter("input_room_type").length() > 0) {
            room.setRoomTypeName(request.getParameter("input_room_type"));
        } else {
            room.setRoomTypeName("NoNamed");
        }
        if (request.getParameter("input_normal_price") != null) {
            try {
                BigDecimal bd = new BigDecimal(request.getParameter("input_normal_price"));
                room.setRoomPrice(bd);
            } catch (Exception e) {
                room.setRoomPrice(new BigDecimal(0));
            }
        } else if (create) {
            room.setRoomPrice(new BigDecimal(0));
        }
        if (request.getParameter("input_sq_ft") != null) {
            try {
                BigDecimal bd = new BigDecimal(request.getParameter("input_sq_ft"));
                room.setRoomSize(bd);
            } catch (Exception e) {
                room.setRoomSize(new BigDecimal(0));
            }
        } else if (create) {
            room.setRoomSize(new BigDecimal(0));
        }
        if (request.getParameter("input_total_quantity") != null) {
            try {
                room.setQuantity(Integer.parseInt(request.getParameter("input_total_quantity")));
            } catch (Exception e) {
                room.setQuantity(0);
            }
        } else if (create) {
            room.setQuantity(0);
        }
        if (request.getParameter("input_room_description") != null && request.getParameter("input_room_description").length() > 0) {
            room.setRoomDescription(request.getParameter("input_room_description"));
        } else {
            room.setRoomDescription("No Description");
        }
//        if (request.getParameterValues("input_amenities") != null) {
//            room.setRoomDescription(request.getParameterValues("input_amenities")[0]);
//        }
        room.setActivated(request.getParameter("activated_field") != null);
        Boolean result = false;
        if (create) {
            room = (RoomType) rsb.createObject(room);
            if (room != null) {
                result = true;
            }
        } else {
            result = rsb.saveChange(room);
        }
        if (result && request.getParameterValues("input_amenities") != null && room.getRoomTypeId() != null) {
            String[] selectedOptions = request.getParameterValues("input_amenities");
            if (selectedOptions.length == 0 || selectedOptions[0].compareToIgnoreCase("-1") == 0) {
                rsb.saveAmenities(room.getRoomTypeId(), new String[0]);
            } else {
                rsb.saveAmenities(room.getRoomTypeId(), selectedOptions);
            }
        } else if (create && room.getRoomTypeId() != null) {
            rsb.saveAmenities(room.getRoomTypeId(), new String[0]);
        }
        if (result) {
            %> <jsp:forward page="room-management.jsp" /> <%
        }
    }
%>
<div class="container">
    <h1 class="title"><%= request.getParameter("aid") != null ? "Edit" : "Create" %> Room Type</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation" class="active"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div class="tab-pane active">
                <form action='room-type-management.jsp<%= room != null ? "?rid=" + room.getRoomTypeId() : "" %>' method="POST" class="form-horizontal">
                    <div class="form-group">
                        <label for="field_id" class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-9">
                            <input name="field_id" type="text" class="form-control" id="field_id" readonly value="<%= room != null ? room.getRoomTypeId() : "Creating" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_room_type" class="col-sm-3 control-label">Room Type</label>
                        <div class="col-sm-9">
                            <input name="input_room_type" type="text" class="form-control" id="input_room_type" placeholder="Room Type" value="<%= room != null ? room.getRoomTypeName() : "" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_normal_price" class="col-sm-3 control-label">Price</label>
                        <div class="col-sm-9">
                            <input name="input_normal_price" type="number" class="form-control" id="input_normal_price" placeholder="Price" value="<%= room != null ? room.getRoomPrice() : "" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_sq_ft" class="col-sm-3 control-label">Sq. Ft.</label>
                        <div class="col-sm-9">
                            <input name="input_sq_ft" type="number" class="form-control" id="input_sq_ft" placeholder="How big are they" value="<%= room != null ? room.getRoomSize() : "" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_total_quantity" class="col-sm-3 control-label">Total Quantity</label>
                        <div class="col-sm-9">
                            <input name="input_total_quantity" type="number" class="form-control" id="input_total_quantity" placeholder="How many of this type of rooms we have" value="<%= room != null ? room.getQuantity() : "" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_room_description" class="col-sm-3 control-label">Description</label>
                        <div class="col-sm-9">
                            <textarea name="input_room_description"class="form-control" id="input_room_description" placeholder="How great are they?" rows="8"><%= room != null ? room.getRoomDescription() : "" %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_amenities" class="col-sm-3 control-label">Amenities</label>
                        <div class="col-sm-6">
                            <select name="input_amenities"class="form-control" id="input_amenities" multiple>
                                <%
                                    List has = rsb.getAmenities(rid);
                                %>
                                <option value="-1" <%= has.size() == 0 ? "selected" : "" %>>
                                    None
                                </option>
                                <%
                                    List amenities = asb.getAllAmenities(100, 0);
                                    for (Object obj : amenities) {
                                        Amenity amenity = (Amenity)obj;
                                        Boolean selected = false;
                                        for (Object h : has) {
                                            RoomAmenity a = (RoomAmenity)h;
                                            if (a.getAmenityId() == amenity.getAmenityId()) {
                                                selected = true;
                                            }
                                        }
                                        %> <option <%= selected ? "selected" : "" %> value="<%= amenity.getAmenityId() %>"><%= amenity.getAmenityName() %></option> <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9">
                        <div class="checkbox">
                          <label>
                              <input name="activated_field" type="checkbox" <%= room != null && room.getActivated() ? "checked" : "" %>> Active
                          </label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9">
                        <input value="Save" type="submit" class="btn btn-success" />
                      </div>
                    </div>
                  </form>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>