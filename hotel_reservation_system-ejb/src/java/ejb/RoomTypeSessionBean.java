/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vince
 */
@Stateless
public class RoomTypeSessionBean implements RoomTypeSessionBeanRemote, RoomTypeSessionBeanLocal {
    @PersistenceContext(unitName = "hotel_reservation_system-ejbPU")
    private EntityManager em;
    
    @Override
    public List getAllRoomTypes() {
        List allActivatedRoomTypes = (List)em.createNamedQuery("RoomType.findByActivated").setParameter("activated", true).getResultList();
        return allActivatedRoomTypes;
    }

    @Override
    public Object getRoomTypeDetails(int room_type_id) {
        return em.find(RoomType.class, room_type_id);
    }
    
    @Override
    public List getAllRoomTypes(int count, int skip) {
        if (count <= 0) {
            count = 10;
        }
        if (skip < 0) {
            skip = 0;
        }
        List rooms = em.createNamedQuery("RoomType.findAll").setMaxResults(count).setFirstResult(skip).getResultList();
        return rooms;
    }

    @Override
    public int getTotalCount() {
        int count = ((Long)em.createNamedQuery("RoomType.countRoomTypes").getSingleResult()).intValue();
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
    public void deleteObject(int id) {
        try {
            Object obj = em.find(RoomType.class, id);
            em.remove(obj);
            em.flush();
        } catch (Exception e) {
        }
    }

    @Override
    public List getAmenities(int rid) {
        List amenities = em.createNamedQuery("RoomAmenity.findByRoomTypeId").setParameter("roomTypeId", rid).getResultList();
        return amenities;
    }

    @Override
    public Boolean saveAmenities(int rid, String[] amenitieIDs) {
        em.createNamedQuery("RoomAmenity.removeByRoomTypeId").setParameter("roomTypeId", rid).executeUpdate();
        em.flush();
        for (String str : amenitieIDs) {
            RoomAmenity ra = new RoomAmenity();
            ra.setRoomTypeId(rid);
            try {
                int aid = Integer.parseInt(str);
                ra.setAmenityId(aid);
                em.persist(ra);
            } catch (Exception e) {
            }
        }
        em.flush();
        return true;
    }
}
