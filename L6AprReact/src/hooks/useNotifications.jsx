import { createConsumer } from "@rails/actioncable"
import { useEffect, useState } from "react"

export const useNotifications = (userId) => {
    const [notifications, setNotifications] = useState([])
    const [unreadCount, setUnreadCount] = useState(0)

    useEffect(() => {
        const token = localStorage.getItem('token');
        const consumer = createConsumer(`ws://localhost:3000/cable?token=${token}`)

        const subscription = consumer.subscriptions.create("NotificationChannel", {
            received(data) {
                setNotifications((prev) => [data, ...prev])
                setUnreadCount((count) => count + 1)

            }
        })

        return () => {
            subscription.unsubscribe();
            consumer.disconnect();
        }
    }, [userId])
    return { notifications, unreadCount, setUnreadCount }
}