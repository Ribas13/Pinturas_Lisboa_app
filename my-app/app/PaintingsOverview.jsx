import { StyleSheet, Text, View } from 'react-native'
import React from 'react'
import { createStackNavigator } from '@react-navigation/stack';
import { NavigationContainer } from '@react-navigation/native';
import { Colors } from './colors';

const Stack = createStackNavigator();

const PaintingsOverviewScreen = () => {
  return (
	<View style={styles.container}>
	  <Text style={styles.text}>PaintingsOverview</Text>
	</View>
  );
};

const PaintingsOverview = () => {
	return (
			<Stack.Screen
				name="PaintingsOverview"
				component={PaintingsOverviewScreen}
				options={{
					title: 'Paintings Overview',
					headerStyle: { backgroundColor: Colors.primary},
					headerTintColor: Colors.text }}
			/>
	)
}

export default PaintingsOverview

const styles = StyleSheet.create({
	container: {
	  flex: 1,
	  justifyContent: 'center',
	  alignItems: 'center',
	  backgroundColor: Colors.background,
	},
	text: {
		color: Colors.Text,
	}
  });