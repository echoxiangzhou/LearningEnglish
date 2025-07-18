/**
 * Notification Container Component
 * 
 * Displays toast notifications and alerts
 */

import React, { useEffect } from 'react';
import { notification } from 'antd';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { removeNotification } from '../../store/slices/uiSlice';

const NotificationContainer: React.FC = () => {
  const dispatch = useAppDispatch();
  const { notifications } = useAppSelector((state) => state.ui);
  
  const [api, contextHolder] = notification.useNotification();

  useEffect(() => {
    notifications.forEach((notif) => {
      api[notif.type]({
        key: notif.id,
        message: notif.title,
        description: notif.message,
        duration: notif.duration ? notif.duration / 1000 : 4.5,
        onClose: () => {
          dispatch(removeNotification(notif.id));
        },
      });
    });
  }, [notifications, api, dispatch]);

  return <>{contextHolder}</>;
};

export default NotificationContainer;