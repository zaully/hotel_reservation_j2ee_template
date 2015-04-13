<%@page import="java.util.Calendar"%>
<%@include file="header.jsp" %>
<%    
    ReservationSessionBeanRemote reservationsb = (ReservationSessionBeanRemote) ctx.lookup(ReservationSessionBeanRemote.class.getName());
    RoomTypeSessionBeanRemote roomsb = (RoomTypeSessionBeanRemote) ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
    if (reservationsb == null || roomsb == null || request.getParameter("rid") == null) {
%> <jsp:forward page="index.jsp" /> <%
            }
            int rid = 0;
            try {
                rid = Integer.parseInt(request.getParameter("rid"));
            } catch (Exception e) {
%> <jsp:forward page="reservation-management.jsp" /> <%
            }
            Reservation reservation = (Reservation) reservationsb.getReservation(rid);
            User user = (User) ub.getLoggedUser();
            if (user == null || reservation == null || (user.getUserRoleId() != 1 && user.getUserId() != reservation.getUserId())) {
%> <jsp:forward page="reservation-management.jsp" /> <%
            }
            User bookedUser = (User) ub.getUserByUID(reservation.getUserId());
            Calendar cld = Calendar.getInstance();
%>
<div class="container">
    <h2>Reservation Details</h2>
    <!-- reservation-information -->
    <div id="information" class="spacer-sm reserve-info ">
        <div class="container">
            <div class="row">
                <div class="col-sm-7 col-md-8">
                    <div id="RoomDetails" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="item active"><img src="images/photos/8.jpg" class="img-responsive" alt="slide"></div>
                            <div class="item  height-full"><img src="images/photos/9.jpg"  class="img-responsive" alt="slide"></div>
                            <div class="item  height-full"><img src="images/photos/10.jpg"  class="img-responsive" alt="slide"></div>
                        </div>
                        <!-- Controls -->
                        <a class="left carousel-control" href="#RoomDetails" role="button" data-slide="prev"><i class="fa fa-angle-left"></i></a>
                        <a class="right carousel-control" href="#RoomDetails" role="button" data-slide="next"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <div class="col-sm-5 col-md-4">
                    <div id="index-tab-content" class="tab-content">
                        <br />
                        <div class="tab-pane active" id="book_info_form">
                            <form role="form" class="wowload fadeInRight">
                                <div class="form-group">
                                    <input type="text" class="form-control" readonly placeholder="Name" value="<%= bookedUser.getName()%>">
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control" readonly placeholder="Email" value="<%= bookedUser.getEmail()%>">
                                </div>
                                <div class="form-group">
                                    <input type="Phone" class="form-control" readonly placeholder="Phone" value="<%= bookedUser.getPhone()%>">
                                </div>        
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <select disabled class="form-control">
                                                <option><%= reservation.getRoomsQuantity()%></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2">
                                            From
                                            <% cld.setTime(reservation.getStartsFrom());%>
                                        </div>
                                        <div class="col-xs-3">
                                            <select disabled class="form-control col-sm-2" name="from-day" id="to-day">
                                                <option selected><%= cld.get(Calendar.DAY_OF_MONTH)%></option>
                                            </select>
                                        </div>
                                        <div class="col-xs-4">
                                            <select disabled class="form-control col-sm-2" name="from-month" id="to-month">
                                                <option selected><%= cld.get(Calendar.MONTH) + 1%></option>
                                            </select>
                                        </div>
                                        <div class="col-xs-3">
                                            <select disabled class="form-control" name="from-year">
                                                <option selected><%= cld.get(Calendar.YEAR)%></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2">
                                            To
                                            <% cld.setTime(reservation.getEndsAt());%>
                                        </div>
                                        <div class="col-xs-3">
                                            <select class="form-control col-sm-2" name="to-day" id="to-day">
                                                <option selected><%= cld.get(Calendar.DAY_OF_MONTH)%></option>
                                            </select>
                                        </div>
                                        <div class="col-xs-4">
                                            <select class="form-control col-sm-2" name="to-month" id="to-month">
                                                <option selected><%= cld.get(Calendar.MONTH) + 1%></option>
                                            </select>
                                        </div>
                                        <div class="col-xs-3">
                                            <select class="form-control" name="to-year">
                                                <option selected><%= cld.get(Calendar.YEAR)%></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <textarea class="form-control"  placeholder="Additional Message" rows="4"><%= reservation.getAdditionalMessage()%></textarea>
                                </div>
                            </form>
                                <a class="btn btn-default" href="reservation-management.jsp" >Back</a>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
    </div>
    <!-- reservation-information -->
</div>
<%@include file="footer.jsp" %>