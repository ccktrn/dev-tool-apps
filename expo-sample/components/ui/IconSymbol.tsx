// Material Icons: https://materialdesignicons.com/
// Material Community Icons: https://materialdesignicons.com/

import { MaterialCommunityIcons, MaterialIcons } from '@expo/vector-icons';
import { SymbolWeight } from 'expo-symbols';
import React from 'react';
import { OpaqueColorValue, StyleProp, ViewStyle } from 'react-native';

type MaterialIconName = React.ComponentProps<typeof MaterialIcons>['name']
type MaterialCommunityIconName = React.ComponentProps<typeof MaterialCommunityIcons>['name']

export type IconSymbolName = MaterialIconName | MaterialCommunityIconName;

export function IconSymbol({
  name,
  size = 24,
  color,
  style,
}: {
  name: IconSymbolName;
  size?: number;
  color: string | OpaqueColorValue;
  style?: StyleProp<ViewStyle>;
  weight?: SymbolWeight;
}) {

  return (name in MaterialCommunityIcons.glyphMap) ?
    <MaterialCommunityIcons color={color} size={size} name={ name as MaterialCommunityIconName } style={style} />
    : <MaterialIcons color={color} size={size} name={ name as MaterialIconName } style={style} />
  
}
