import SwiftUI
import shared

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeScreen(viewModel: HomeScreen.ViewModel())
        }
        .preferredColorScheme(.light)
    }
}
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
