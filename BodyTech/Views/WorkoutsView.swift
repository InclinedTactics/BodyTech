//
//  WorkoutsView.swift
//  BodyTech
//
//  Created by Joseph DeWeese on 4/12/24.
//

import SwiftUI
import RealmSwift

struct WorkoutsView: View {
    @ObservedResults(DailyWorkout.self) var workouts
    @State private var isPresented = false
    @State private var newWorkoutData = DailyWorkout.Data()
    @State private var currentWorkout = DailyWorkout()
    
    /// For Animation
    @Namespace private var animation
    var body: some View {
                
    NavigationStack{
        HStack(spacing: 10) {
            NavigationLink{
                ProfileView()
                
            } label: {
                VStack{
                    ZStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 47, height: 47)
                            .shadow(color: .primary, radius: 1, x: 1, y: 1)
                        
                        Image("profilePic")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 42, height: 42)
                    }
                }
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("One Day Closer!")
                    .fontDesign(.serif)
                    .font(.title2.bold())
                   
                
                Text("...your physical API.")
                    .font(.callout.bold())
                    .fontDesign(.serif)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
            ///Add Workout Button
            Button {
                isPresented = true
                HapticManager.notification(type: .success)
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 42, height: 42)
                    .background(.colorBlue2, in: .circle)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            }
        }.padding(.horizontal, 4)
        VStack{
            ScrollView {
                //      if let scrums = scrums {
                LazyVStack(spacing: 0.5, pinnedViews: [.sectionHeaders]){
                   
                        ForEach(workouts) { workout in
                            NavigationLink(destination: WorkoutDetailView()) {
                                WorkoutCardView()
                            }
                            .listRowBackground(workout.color)
                        }
                    }
                }
            }
        }
    
                    .sheet(isPresented: $isPresented) {
                    NavigationView {
                        WorkoutEditView()
                            .navigationBarItems(leading: Button("Dismiss") {
                                isPresented = false
                            }, trailing: Button("Save") {
                                let newWorkout = DailyWorkout(
                                    title: newWorkoutData.title,
                                    woDetails: newWorkoutData.woDetails,
                                    exercises: newWorkoutData.exercises,
                                    lengthInMinutes: Int(newWorkoutData.lengthInMinutes),
                                    color: newWorkoutData.color)
                                $workouts.append(newWorkout)
                                HapticManager.notification(type: .success)
                                isPresented = false
                            })
                    }
                }
            }
        }
    
struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsView()
        }
    }
}
                 
