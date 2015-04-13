/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author vince
 */
@Entity
@Table(name = "reservation")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Reservation.findAll", query = "SELECT r FROM Reservation r"),
    @NamedQuery(name = "Reservation.countReservations", query="SELECT COUNT(r) FROM Reservation r"),
    @NamedQuery(name = "Reservation.findAllWithRange", query = "SELECT r FROM Reservation r where r.startsFrom <= :endsAt and r.endsAt >= :startsFrom"),
    @NamedQuery(name = "Reservation.countReservationsWithRange", query="SELECT COUNT(r) FROM Reservation r where r.startsFrom <= :endsAt and r.endsAt >= :startsFrom"),
    @NamedQuery(name = "Reservation.findByReservationId", query = "SELECT r FROM Reservation r WHERE r.reservationId = :reservationId"),
    @NamedQuery(name = "Reservation.findByUserId", query = "SELECT r FROM Reservation r WHERE r.userId = :userId"),
    @NamedQuery(name = "Reservation.findByRoomTypeId", query = "SELECT r FROM Reservation r WHERE r.roomTypeId = :roomTypeId"),
    @NamedQuery(name = "Reservation.findByStartsFrom", query = "SELECT r FROM Reservation r WHERE r.startsFrom = :startsFrom"),
    @NamedQuery(name = "Reservation.findByEndsAt", query = "SELECT r FROM Reservation r WHERE r.endsAt = :endsAt"),
    @NamedQuery(name = "Reservation.findByRoomsQuantity", query = "SELECT r FROM Reservation r WHERE r.roomsQuantity = :roomsQuantity")})
public class Reservation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "reservation_id")
    private Integer reservationId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "user_id")
    private int userId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "room_type_id")
    private int roomTypeId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "starts_from")
    @Temporal(TemporalType.DATE)
    private Date startsFrom;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ends_at")
    @Temporal(TemporalType.DATE)
    private Date endsAt;
    @Basic(optional = false)
    @NotNull
    @Column(name = "rooms_quantity")
    private int roomsQuantity;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "additional_message")
    private String additionalMessage;

    public Reservation() {
    }

    public Reservation(Integer reservationId) {
        this.reservationId = reservationId;
    }

    public Reservation(Integer reservationId, int userId, int roomTypeId, Date startsFrom, Date endsAt, int roomsQuantity, String additionalMessage) {
        this.reservationId = reservationId;
        this.userId = userId;
        this.roomTypeId = roomTypeId;
        this.startsFrom = startsFrom;
        this.endsAt = endsAt;
        this.roomsQuantity = roomsQuantity;
        this.additionalMessage = additionalMessage;
    }

    public Integer getReservationId() {
        return reservationId;
    }

    public void setReservationId(Integer reservationId) {
        this.reservationId = reservationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public Date getStartsFrom() {
        return startsFrom;
    }

    public void setStartsFrom(Date startsFrom) {
        this.startsFrom = startsFrom;
    }

    public Date getEndsAt() {
        return endsAt;
    }

    public void setEndsAt(Date endsAt) {
        this.endsAt = endsAt;
    }

    public int getRoomsQuantity() {
        return roomsQuantity;
    }

    public void setRoomsQuantity(int roomsQuantity) {
        this.roomsQuantity = roomsQuantity;
    }

    public String getAdditionalMessage() {
        return additionalMessage;
    }

    public void setAdditionalMessage(String additionalMessage) {
        this.additionalMessage = additionalMessage;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (reservationId != null ? reservationId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Reservation)) {
            return false;
        }
        Reservation other = (Reservation) object;
        if ((this.reservationId == null && other.reservationId != null) || (this.reservationId != null && !this.reservationId.equals(other.reservationId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ejb.Reservation[ reservationId=" + reservationId + " ]";
    }
    
}
