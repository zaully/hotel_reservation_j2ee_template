/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TemporalType;

/**
 *
 * @author vince
 */
@Stateless
public class ReservationSessionBean implements ReservationSessionBeanRemote, ReservationSessionBeanLocal {
    @PersistenceContext(unitName = "hotel_reservation_system-ejbPU")
    private EntityManager em;
    

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    
    @Override
    public List getAllReservation(int count, int skip)
    {
        if (count <= 0) {
            count = 50;
        }
        if (skip < 0) {
            skip = 0;
        }
        return em.createNamedQuery("Reservation.findAll").setMaxResults(count).setFirstResult(skip).getResultList();
    }
    
    @Override
    public int getTotalCount() {
        int count = ((Long)em.createNamedQuery("Reservation.countReservations").getSingleResult()).intValue();
        return count;
    }
    
    @Override
    public Boolean createObject(Object obj) {
        em.persist(obj);
        em.flush();
        if(((RoomType)obj).getRoomTypeId()> 0) {
            return true;
        }
        return false;
    }
    
    @Override
    public Boolean saveChange(Object obj) {
        try {
            em.merge(obj);
            em.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public void deleteObject(int id)
    {
        try {
            Object obj = em.find(Reservation.class, id);
            em.remove(obj);
            em.flush();
        } catch (Exception e) {
        }
    }

    @Override
    public Object getReservation(int rid) {
        return em.find(Reservation.class, rid);
    }

    @Override
    public List getAllReservation(int count, int skip, Date start, Date end) {
        if (count <= 0) {
            count = 50;
        }
        if (skip < 0) {
            skip = 0;
        }
        if (start == null) {
            Calendar cld = Calendar.getInstance();
            cld.add(Calendar.YEAR, -1);
            start =  cld.getTime();
        }
        if (end == null) {
            Calendar cld = Calendar.getInstance();
            cld.add(Calendar.YEAR, 2);
            end =  cld.getTime();
        }
        //return em.createQuery("SELECT r FROM Reservation r where (r.startsFrom <= '2010-01-01') and (r.endsAt >= '2020-01-01')").setMaxResults(count).setFirstResult(skip).getResultList();
        return em.createNamedQuery("Reservation.findAllWithRange").setParameter("endsAt", end, TemporalType.DATE).setParameter("startsFrom", start, TemporalType.DATE).setMaxResults(count).setFirstResult(skip).getResultList();
    }
    
    @Override
    public List getAllReservation(int uid, int rid, int count, int skip, Date start, Date end) {
        if (count <= 0) {
            count = 50;
        }
        if (skip < 0) {
            skip = 0;
        }
        if (start == null) {
            Calendar cld = Calendar.getInstance();
            cld.add(Calendar.YEAR, -1);
            start =  cld.getTime();
        }
        if (end == null) {
            Calendar cld = Calendar.getInstance();
            cld.add(Calendar.YEAR, 2);
            end =  cld.getTime();
        }
        if (uid == 0 && rid == 0) {
            return this.getAllReservation(count, skip, start, end);
        } else if (rid == 0) {
            return em.createQuery("SELECT r FROM Reservation r WHERE r.userId = :userId and r.startsFrom <= :endsAt and r.endsAt >= :startsFrom ORDER BY r.startsFrom DESC")
                        .setParameter("userId", uid)
                        .setParameter("endsAt", end, TemporalType.DATE)
                        .setParameter("startsFrom", start, TemporalType.DATE)
                        .setMaxResults(count).setFirstResult(skip).getResultList();
        } else if (uid == 0) {
            return em.createQuery("SELECT r FROM Reservation r WHERE r.roomTypeId = :roomTypeId and r.startsFrom <= :endsAt and r.endsAt >= :startsFrom ORDER BY r.startsFrom DESC")
                        .setParameter("roomTypeId", rid)
                        .setParameter("endsAt", end, TemporalType.DATE)
                        .setParameter("startsFrom", start, TemporalType.DATE)
                        .setMaxResults(count).setFirstResult(skip).getResultList();
        }
        return em.createQuery("SELECT r FROM Reservation r WHERE r.roomTypeId = :roomTypeId and r.userId = :userId and r.startsFrom <= :endsAt and r.endsAt >= :startsFrom ORDER BY r.startsFrom DESC")
                    .setParameter("roomTypeId", rid)
                    .setParameter("userId", uid)
                    .setParameter("endsAt", end, TemporalType.DATE)
                    .setParameter("startsFrom", start, TemporalType.DATE)
                    .setMaxResults(count).setFirstResult(skip).getResultList();
    }
    
    @Override
    public int getTotalCount(Date start, Date end) {
        if (start == null) {
            Calendar cld = Calendar.getInstance();
            cld.add(Calendar.YEAR, -1);
            start =  cld.getTime();
        }
        if (end == null) {
            Calendar cld = Calendar.getInstance();
            cld.add(Calendar.YEAR, 2);
            end =  cld.getTime();
        }
        //int count = ((Long)em.createQuery("SELECT COUNT(r) FROM Reservation r where (r.startsFrom <= '2010-01-01') and (r.endsAt >= '2020-01-01')").getSingleResult()).intValue();
        int count = ((Long)em.createNamedQuery("Reservation.countReservationsWithRange").setParameter("endsAt", end, TemporalType.DATE).setParameter("startsFrom", start, TemporalType.DATE).getSingleResult()).intValue();
        return count;
    }

    @Override
    public Date getLastVisitByUserID(int uid) {
        try {
            List reservations = em.createQuery("SELECT r FROM Reservation r WHERE r.userId = :userId and r.startsFrom <= :endsAt ORDER BY r.startsFrom DESC").setParameter("userId", uid).setParameter("endsAt", Calendar.getInstance().getTime()).getResultList();
            if (reservations.size() > 0) {
                Reservation reservation = (Reservation)reservations.get(0);
                if (reservation != null) {
                    return reservation.getStartsFrom();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int getVisitsByUserID(int uid) {
        int count = ((Long)em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.userId = :userId and r.startsFrom <= :endsAt").setParameter("userId", uid).setParameter("endsAt", Calendar.getInstance().getTime()).getSingleResult()).intValue();
        return count;
    }

    @Override
    public Boolean reserve(int rid, int uid, Date from, Date to, int quantity, String additional_message) {
        RoomType room = em.find(RoomType.class, rid);
        List reservations = this.getAllReservation(0, rid, 100, 0, from, to);
        if (room.getQuantity() - reservations.size() < quantity) {
            return false;
        }
        List userReservations = this.getAllReservation(uid, 0, 100, 0, from, to);
        if (userReservations.size() > 0) {
            return false;
        }
        Reservation res = new Reservation();
        res.setUserId(uid);
        res.setRoomTypeId(rid);
        res.setStartsFrom(from);
        res.setEndsAt(to);
        res.setAdditionalMessage(additional_message);
        res.setRoomsQuantity(quantity);
        em.persist(res);
        em.flush();
        return true;
    }

    @Override
    public Boolean saveReservation(int res, Date from, Date to, int quantity, String additional_message) {
        Reservation reservation = (Reservation)em.find(Reservation.class, res);
        reservation.setStartsFrom(from);
        reservation.setEndsAt(to);
        reservation.setAdditionalMessage(additional_message);
        reservation.setRoomsQuantity(quantity);
        return this.saveChange(reservation);
    }
}
