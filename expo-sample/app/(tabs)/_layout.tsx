import { Stack, Tabs } from 'expo-router';
import React, { Key } from 'react';
import { Platform } from 'react-native';

import { HapticTab } from '@/components/HapticTab';
import { IconSymbol, IconSymbolName } from '@/components/ui/IconSymbol';
import TabBarBackground from '@/components/ui/TabBarBackground';
import { Colors } from '@/constants/Colors';
import { useColorScheme } from '@/hooks/useColorScheme';


interface TabConfig {
  path : string;
  title: string;
  icon: IconSymbolName;
}

const TabConfigs: TabConfig[] = [
  {
    path: 'index',
    title: 'Index',
    icon: 'bug',  
  },
  {
    path: 'welcome',
    title: 'Welcome',
    icon: 'home',
  },
  {
    path: 'explore',
    title: 'Explore',
    icon: 'send',
  },
]

const createTab = (config:TabConfig, key?:Key) => (
    <Tabs.Screen
      key={key ?? config.path}
      name={config.path}
      options= {{
        title: config.title,
        tabBarIcon: ({ color }) => <IconSymbol size={28} name={config.icon} color={color} />,
      }}
    />
  )

export default function TabLayout() {
  const colorScheme = useColorScheme();

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: Colors[colorScheme ?? 'light'].tint,
        headerShown: false,
        tabBarButton: HapticTab,
        tabBarBackground: TabBarBackground,
        tabBarStyle: Platform.select({
          ios: {
            // Use a transparent background on iOS to show the blur effect
            position: 'absolute',
          },
          default: {},
        }),
      }}>
      {TabConfigs.map(createTab)}
    </Tabs>
  );
}
