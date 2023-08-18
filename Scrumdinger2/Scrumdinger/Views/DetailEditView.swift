import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptySurum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMiuntesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) miuntes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) miuntes")
                        .accessibilityHidden(true)
                }
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendees = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendees)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
