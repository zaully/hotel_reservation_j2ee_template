/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.security.MessageDigest;
import java.util.List;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vince
 */
@Stateful
public class UserSessionBean implements UserSessionBeanRemote, UserSessionBeanLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private User loggedUser = null;
    
    @PersistenceContext(unitName = "hotel_reservation_system-ejbPU")
    private EntityManager em;

    @Override
    public Boolean login(String email, String password) {
        List users = em.createNamedQuery("User.findByEmail").setParameter("email", email).getResultList();
        if (users.size() > 0) {
            User user = (User) users.get(0);
            if (user != null) {
                String strPw = UserSessionBean.hashedPassword(password);
                if (strPw.compareTo(user.getPassword()) == 0) {
                    loggedUser = user;
                    return true;
                }
            }
        }
        loggedUser = null;
        return false;
    }

    @Override
    public void logout() {
        loggedUser = null;
    }
    
    public static String hashedPassword(String native_password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(native_password.getBytes());
            byte byteData[] = md.digest();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < byteData.length; i++) {
             sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
            return sb.toString();
        } catch (Exception e) {
        }
        return "";
    }

    @Override
    public Boolean register(Object user) {
        ((User)user).setPassword(UserSessionBean.hashedPassword(((User)user).getPassword()));
        em.persist(user);
        em.flush();
        if(((User)user).getUserId() > 0) {
            loggedUser = (User)user;
            return true;
        }
        loggedUser = null;
        return false;
    }

    @Override
    public Boolean isLoggedIn() {
        return (loggedUser != null);
    }

    @Override
    public int getUserRoleID() {
        if (loggedUser != null) {
            return loggedUser.getUserRoleId();
        }
        return -1;
    }

    @Override
    public Object getLoggedUser() {
        if (loggedUser != null) {
            return loggedUser;
        }
        return null;
    }

    @Override
    public Boolean saveChange(Object user) {
        try {
            User u = (User) user;
            if (u.getPassword().length() < 20) {
                u.setPassword(UserSessionBean.hashedPassword(u.getPassword()));
            }
            em.merge(u);
            em.flush();
            loggedUser = u;
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List getUsers(int count, int skip) {
        if (count <= 0) {
            count = 10;
        }
        if (skip <= 1) {
            skip = 0;
        }
        List users = em.createNamedQuery("User.findAll").setMaxResults(count).setFirstResult(skip).getResultList();
        return users;
    }

    @Override
    public int getUsersPageCount() {
        int count = ((Long)em.createNamedQuery("User.countUsers").getSingleResult()).intValue();
        return count;
    }

    @Override
    public Object getUserByUID(int uid) {
        return em.find(User.class, uid);
    }
}
