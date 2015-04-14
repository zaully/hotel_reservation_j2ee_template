<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null) {
        %> <jsp:forward page="login.jsp" /> <%
    }
    RoomTypeSessionBeanRemote roomsb = (RoomTypeSessionBeanRemote)ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
    if (roomsb == null) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    int rid = 0;
    int res = 0;
    Boolean modifying = false;
    if (request.getParameter("rid") != null) {
        try {
            rid = Integer.parseInt(request.getParameter("rid"));
        } catch (Exception e) {
            %> <jsp:forward page="index.jsp" /> <%
        }
    }
    if (request.getParameter("res") != null) {
        try {
            modifying = true;
            res = Integer.parseInt(request.getParameter("res"));
        } catch (Exception e) {
            %> <jsp:forward page="index.jsp" /> <%
        }
    }
    RoomType room = (RoomType)roomsb.getRoomTypeDetails(rid);
    if (room == null && !modifying) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    ReservationSessionBeanRemote rsb = (ReservationSessionBeanRemote)ctx.lookup(ReservationSessionBeanRemote.class.getName());
    if (rsb == null && modifying) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    Boolean result = false;
    if (request.getMethod().compareToIgnoreCase("post") == 0) {
        try {
            Calendar cldfrom = Calendar.getInstance();
            cldfrom.set(Calendar.YEAR, Integer.parseInt(request.getParameter("from-year")));
            cldfrom.set(Calendar.MONTH, Integer.parseInt(request.getParameter("from-month")));
            cldfrom.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request.getParameter("from-day")));
            Calendar cldto = Calendar.getInstance();
            cldto.set(Calendar.YEAR, Integer.parseInt(request.getParameter("to-year")));
            cldto.set(Calendar.MONTH, Integer.parseInt(request.getParameter("to-month")));
            cldto.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request.getParameter("to-day")));
            int quantity = Integer.parseInt(request.getParameter("rooms"));
            String additional_message = request.getParameter("additional_message");
            if (request.getParameter("reserve") != null) {
                result = rsb.reserve(rid, user.getUserId(), cldfrom.getTime(), cldto.getTime(), quantity, additional_message);
            } else {
                Reservation oldRes = (Reservation)rsb.getReservation(res);
                rsb.saveReservation(res, cldfrom.getTime(), cldto.getTime(), quantity, additional_message);
            }
            %> <jsp:forward page="profile.jsp" /> <%
        } catch (Exception e) {
            result = false;
        }
    }
    Reservation reservation = (Reservation)rsb.getReservation(res);
    if (reservation == null && modifying) {
        %> <jsp:forward page="index.jsp" /> <%
    }
%>
<div class="container">
<h2>Room Reservation</h2>
    <!-- reservation-information -->
    <div id="information" class="spacer-sm reserve-info ">
        <div class="container">
            <div class="row">
                <div class="col-sm-7 col-md-8">
                    <div id="RoomDetails" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="item active"><img src="images/photos/<%= r.nextInt(4) + 8 %>.jpg" class="img-responsive" alt="slide"></div>
                        <div class="item  height-full"><img src="images/photos/<%= r.nextInt(4) + 8 %>.jpg"  class="img-responsive" alt="slide"></div>
                        <div class="item  height-full"><img src="images/photos/<%= r.nextInt(4) + 8 %>.jpg"  class="img-responsive" alt="slide"></div>
                        </div>
                        <!-- Controls -->
                        <a class="left carousel-control" href="#RoomDetails" role="button" data-slide="prev"><i class="fa fa-angle-left"></i></a>
                        <a class="right carousel-control" href="#RoomDetails" role="button" data-slide="next"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <div class="col-sm-5 col-md-4">
                <%
                if(request.getMethod().compareToIgnoreCase("post") == 0 && result == false) {
                %>
                <div class="alert alert-danger alert-dismissable" role="alert">
                    <button type="button" class="close" data-dismiss="alert" 
                       aria-hidden="true">
                       &times;
                    </button>
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <span class="sr-only">Error:</span>Reservation failed!
                </div>
                <% }%>
                    <div id="index-tab-content" class="tab-content">
                        <br />
                        <div class="tab-pane active" id="book_info_form">
                            <form action="book-room.jsp" method='POST' role="form" class="wowload fadeInRight">
                                <input name='rid' type='hidden' value='<%= modifying ? reservation.getRoomTypeId() : room.getRoomTypeId() %>' />
                                <input name='res' type='hidden' value='<%= modifying ? reservation.getReservationId(): 0 %>' />
                                <input name='uid' type='hidden' value='<%= user.getUserId() %>' />
                                <div class="form-group">
                                    <input name='name' type="text" value='<%= user.getName() %>' readonly class="form-control"  placeholder="Name">
                                </div>
                                <div class="form-group">
                                    <input name='email' type="email" value='<%= user.getEmail() %>' readonly class="form-control"  placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <input name='phone' type="Phone" value='<%= user.getPhone() %>' readonly class="form-control"  placeholder="Phone">
                                </div>        
                                <div class="form-group">
                                    <div class="row">
                                    <div class="col-xs-6">
                                    <select name='rooms' class="form-control">
                                      <option <%= !modifying ? "selected" : "" %> disabled>No. of Rooms</option>
                                      <% for (int i = 0; i < 3; i++) { %>
                                      <option <%= reservation != null && reservation.getRoomsQuantity() == i + 1 ? "selected" : "" %> value="<%= i + 1 %>"><%= i + 1 %></option>
                                      <%}%>
                                    </select>
                                    </div>
                                    </div>
                                </div>
                                    <%
                                      Calendar cldFrom = Calendar.getInstance();
                                      Calendar cldTo = Calendar.getInstance();
                                      if (modifying && reservation != null) {
                                        cldFrom.setTime(reservation.getStartsFrom());
                                        cldTo.setTime(reservation.getEndsAt());
                                      }
                                    %>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2">
                                            From
                                        </div>
                                    <div class="col-xs-3">
                                      <select class="form-control col-sm-2" name="from-day" id="to-day">
                                        <option <%= !modifying ? "selected" : "" %> disabled>Date</option>
                                        <% for (int i = 0; i < 31; i++) { %>
                                        <option <%= modifying && cldFrom.get(Calendar.DAY_OF_MONTH) == i + 1 ? "selected" : "" %> value="<%= i + 1 %>"><%= i + 1 %></option>
                                        <%}%>
                                      </select>
                                    </div>
                                    <div class="col-xs-4">
                                      <select class="form-control col-sm-2" name="from-month" id="to-month">
                                          <option <%= !modifying ? "selected" : "" %> disabled="">Month</option>
                                        <% for (int i = 0; i < 12; i++) {
                                            DateFormatSymbols dfs = new DateFormatSymbols();
                                            String[] months = dfs.getMonths();
                                        %>
                                        <option <%= modifying && cldFrom.get(Calendar.MONTH) == i ? "selected" : "" %> value="<%= i %>"><%= months[i] %></option>
                                        <%}%>
                                      </select>
                                    </div>
                                    <div class="col-xs-3">
                                      <select class="form-control" name="from-year">
                                        <% for (int i = 2015; i < 2023; i++) { %>
                                        <option <%= modifying && cldFrom.get(Calendar.YEAR) == i ? "selected" : "" %> value="<%= i %>"><%= i %></option>
                                        <% } %>
                                      </select>
                                    </div>
                                  </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2">
                                        To
                                        </div>
                                    <div class="col-xs-3">
                                      <select class="form-control col-sm-2" name="to-day" id="to-day">
                                        <option <%= !modifying ? "selected" : "" %> disabled>Date</option>
                                        <% for (int i = 0; i < 31; i++) { %>
                                        <option <%= modifying && cldTo.get(Calendar.DAY_OF_MONTH) == i + 1 ? "selected" : "" %> value="<%= i + 1 %>"><%= i + 1 %></option>
                                        <%}%>
                                      </select>
                                    </div>
                                    <div class="col-xs-4">
                                      <select class="form-control col-sm-2" name="to-month" id="to-month">
                                          <option <%= !modifying ? "selected" : "" %> disabled="">Month</option>
                                        <% for (int i = 0; i < 12; i++) {
                                            DateFormatSymbols dfs = new DateFormatSymbols();
                                            String[] months = dfs.getMonths();
                                        %>
                                        <option <%= modifying && cldTo.get(Calendar.MONTH) == i ? "selected" : "" %> value="<%= i %>"><%= months[i] %></option>
                                        <%}%>
                                      </select>
                                    </div>
                                    <div class="col-xs-3">
                                      <select class="form-control" name="to-year">
                                        <% for (int i = 2015; i < 2023; i++) { %>
                                        <option <%= modifying && cldTo.get(Calendar.YEAR) == i ? "selected" : "" %> value="<%= i %>"><%= i %></option>
                                        <% } %>
                                      </select>
                                    </div>
                                  </div>
                                </div>
                                <div class="form-group">
                                    <textarea name="additional_message" class="form-control"  placeholder="Additional Message" rows="4"><%= modifying ? reservation.getAdditionalMessage() : user.getPreference() %></textarea>
                                </div>
                                <input type='submit' name='<%= modifying ? "modify" : "reserve" %>' value='<%= modifying ? "Modify" : "Reserve" %>' class="btn btn-default" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
    </div>
    <!-- reservation-information -->
</div>
<%@include file="footer.jsp" %>