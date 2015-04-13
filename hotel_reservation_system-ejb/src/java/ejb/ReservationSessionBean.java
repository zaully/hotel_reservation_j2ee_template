/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
            Reservation reservation = (Reservation)em.createQuery("SELECT r FROM Reservation r WHERE r.userId = :userId and r.startsFrom <= :endsAt ORDER BY r.startsFrom DESC").setParameter("userId", uid).setParameter("endsAt", Calendar.getInstance().getTime()).getSingleResult();
            if (reservation != null) {
                return reservation.getStartsFrom();
            }   
        } catch (Exception e) {
            
        }
        return null;
    }

    @Override
    public int getVisitsByUserID(int uid) {
        int count = ((Long)em.createQuery("SELECT COUNT(r) FROM Reservation r WHERE r.userId = :userId and r.startsFrom <= :endsAt").setParameter("userId", uid).setParameter("endsAt", Calendar.getInstance().getTime()).getSingleResult()).intValue();
        return count;
    }
    
}
