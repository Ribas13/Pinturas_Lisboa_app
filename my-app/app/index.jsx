import { Text, View } from "react-native";
import { Link } from "expo-router";
import { StatusBar } from "expo-status-bar";

export default function Index() {
  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <Text>Welcome to the preview of Pinturas Lisboa app</Text>
	  <StatusBar style="auto" />
      <Link href="/PaintingsOverview" style={{color: 'blue'}}>Go to Paintings Overview</Link>
    </View>
  );
}
