// src/components/Navbar.jsx
import React, { useState, useEffect } from 'react';
import { createConsumer } from "@rails/actioncable";


let consumer = null;

export const disconnectCable = () => {
    if (consumer) {
        consumer.disconnect();
        consumer = null;
        console.log("ActionCable: Disconnected manually");
    }
};

const Navbar = ({user}) => {
    const [unreadCount, setUnreadCount] = useState(0);

    useEffect(() => {
        const token = localStorage.getItem("token");
        if (!token || consumer) return;

        consumer = createConsumer(`ws://patchara.local:3000/cable?token=${token}`);

        const subscription = consumer.subscriptions.create("NotificationChannel", {
            received(data) {
                console.log("Data coming from Rails:", data);
                setUnreadCount(prev => prev + 1);
            },
            connected() {
                console.log("ActionCable: Connected to NotificationChannel");
            }
        });

        return () => {
            subscription.unsubscribe();
            if (consumer) {
                consumer.disconnect();
                consumer = null;
            }
        };
    }, [user]);


    return (
        <nav style={styles.nav}>
            <div style={styles.logo}>DevApp</div>
            <ul style={styles.navLinks}>
                <li>หน้าแรก</li>
                <li style={styles.notificationContainer}>
                    <span>การแจ้งเตือน</span>
                    {unreadCount > 0 && <span style={styles.badge}>{unreadCount}</span>}
                </li>
            </ul>
        </nav>
    );
};

const styles = {

    nav: {
        position: 'fixed',
        right: '0',
        top: '0',
        display: 'flex',

        justifyContent: 'space-between',

        alignItems: 'center',

        padding: '0 2rem',

        height: '60px',

        backgroundColor: '#333',

        color: '#fff',

        boxShadow: '0 2px 5px rgba(0,0,0,0.2)'

    },

    logo: { fontSize: '1.5rem', fontWeight: 'bold' },

    navLinks: {

        display: 'flex',

        listStyle: 'none',

        gap: '2rem',

        alignItems: 'center'

    },

    notificationContainer: { position: 'relative', cursor: 'pointer' },

    badge: {

        position: 'absolute',

        top: '-8px',

        right: '-15px',

        backgroundColor: '#ff4d4f',

        color: 'white',

        borderRadius: '50%',

        padding: '2px 6px',

        fontSize: '11px',

        fontWeight: 'bold'

    },

    logoutBtn: {

        backgroundColor: '#555',

        color: '#fff',

        border: 'none',

        padding: '5px 10px',

        borderRadius: '4px',

        cursor: 'pointer'

    }

};


export default Navbar;