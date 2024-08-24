import { StyleSheet, SafeAreaView } from "react-native";
import { ExampleList } from "./ExampleList";

export function HomeScreen() {
  return (
    <SafeAreaView style={styles.rootContainer}>
      <ExampleList
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContentContainer}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
    backgroundColor: 'white',
  },
  scrollView: {
    flex: 1,
  },
  scrollContentContainer: {
    paddingHorizontal: 10,
    paddingBottom: 100,
    paddingTop: 20,
  },
  exampleListItem: {
    marginBottom: 15,
  },
});
