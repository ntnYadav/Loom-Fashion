//
//  SwiftUIViewFile.swift
//  BridgingSwiftToSwiftUI
//
//  Created by chetu on 09/04/25.
//

import SwiftUI

//struct LoomApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ProductDetailView()
//        }
//    }
//}
struct SecondSwiftUIView: View {
    var goToFinalDestination: () -> Void
    
    var body: some View {
        Button("back", action: {
            goToFinalDestination()
                    })
        ProductDetailView()

    }
}
#Preview {
    SecondSwiftUIView(goToFinalDestination: {
        
        
        
    })
}
//




struct ProductDetailView: View {
    let imageNames = ["photo", "photo.fill", "photo.tv", "photo.on.rectangle", "photo.circle", "camera", "camera.fill"]

    @State private var selectedIndex: Int = 0
    @State private var showFullDetail = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
               
                // MARK: - Image Carousel
                ZStack(alignment: .trailing) {
                    TabView(selection: $selectedIndex) {
                        ForEach(imageNames.indices, id: \.self) { index in
                            Image(systemName: imageNames[index])
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal, 20)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .rotationEffect(.degrees(90))
                    .frame(height: UIScreen.main.bounds.height * 0.6)
                    .clipped()

                    // Dot indicator
                    VStack(spacing: 10) {
                        ForEach(imageNames.indices, id: \.self) { index in
                            Circle()
                                .fill(selectedIndex == index ? Color.black : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.trailing, 12)
                }

                // MARK: - Ships Label
                Text("SHIPS WITHIN 24 HOURS")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.85))

                VStack(alignment: .leading, spacing: 8) {
                    // Drag handle to open full sheet
                    HStack {
                        Spacer()
                        Capsule()
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 40, height: 6)
                            .padding(.vertical, 8)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showFullDetail = true
                                }
                            }
                        Spacer()
                    }
                    HStack {
                        Text("Beige Korean Trousers")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.black)
                        Text("4.4").bold()
                        Text("82 ratings | 6 reviews")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }

                    HStack {
                        Text("₹1599")
                            .strikethrough()
                            .foregroundColor(.gray)
                        Text("₹959")
                            .font(.headline)
                            .bold()
                    }

                   
                }
                .padding(.horizontal)

                Spacer()
            }

            // MARK: - Bottom Fixed Panel
            VStack(spacing: 12) {
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack {
//                        Text("Beige Korean Trousers")
//                            .font(.subheadline)
//                            .bold()
//                        Spacer()
//                        Image(systemName: "square.and.arrow.up")
//                    }
//
//                    HStack(spacing: 4) {
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.black)
//                        Text("4.4").bold()
//                        Text("82 ratings | 6 reviews")
//                            .foregroundColor(.gray)
//                            .font(.subheadline)
//                    }
//                }
//                .padding(.horizontal)

                // ADD TO BAG Button
                Button(action: {
                    withAnimation(.easeInOut) {
                        showFullDetail = true
                    }
                }) {
                    Text("ADD TO BAG")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(4)
                }
                .padding(.horizontal)

                Divider()

                // Bottom Tab Bar
//                HStack {
//                    Spacer()
//                    bottomBarIcon(systemName: "house.fill", label: "Home")
//                    Spacer()
//                    bottomBarIcon(systemName: "play.circle.fill", label: "Shop")
//                    Spacer()
//                    bottomBarIcon(systemName: "bag.fill", label: "Bag", badge: true)
//                    Spacer()
//                    bottomBarIcon(systemName: "person.crop.circle.fill", label: "Profile")
//                    Spacer()
//                }
                .padding(.top, 8)
                .padding(.bottom, 12)
            }
            .background(Color.white)
            .zIndex(1) // Always on top

            // MARK: - Slide-Up NewProductDetailView (Behind Button)
            if showFullDetail {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                NewProductDetailView(showFullDetail: $showFullDetail)
                    .background(Color.white)
                    .cornerRadius(20)
                    .transition(.move(edge: .bottom))
                    .zIndex(0)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.9)
                    .offset(y: showFullDetail ? 0 : UIScreen.main.bounds.height)
                    .animation(.easeInOut, value: showFullDetail)
            }

        }
        .edgesIgnoringSafeArea(.bottom)
    }

    @ViewBuilder
    func bottomBarIcon(systemName: String, label: String, badge: Bool = false) -> some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: systemName)
                if badge {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.caption2)
                        .offset(x: 6, y: -8)
                }
            }
            Text(label)
                .font(.caption2)
        }
    }
}


import SwiftUI


struct NewProductDetailView: View {
    @State private var selectedSize: Int? = 34
    @State private var showDetails = false
    @State private var showOffers = false
    @State private var showReviews = false
    @State private var showDelivery = false
    @State private var showReturns = false
    @Binding var showFullDetail: Bool
    let sizes = [30, 32, 34, 36, 38]

    var body: some View {
        if #available(iOS 16.0, *) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // MARK: - Shutter / Handle Indicator
                    // MARK: - Drag Handle with Dismiss Gesture
                    HStack {
                        Spacer()
                        Capsule()
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 40, height: 6)
                            .padding(.top, 8)
                            .gesture(
                                DragGesture(minimumDistance: 10)
                                    .onEnded { value in
                                        if value.translation.height > 50 {
                                            withAnimation(.easeInOut) {
                                                showFullDetail = false
                                            }
                                        }
                                    }
                            )
                        Spacer()
                    }
                    
                    
                    // MARK: - Title, Rating, and Pricing
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Beige Korean Trousers")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.black)
                            Text("4.4").bold()
                            Text("82 ratings | 6 reviews")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Text("₹1599")
                                .strikethrough()
                                .foregroundColor(.gray)
                            Text("₹959")
                                .font(.headline)
                                .bold()
                        }
                    }
                    
                    // COLORS
                    VStack(alignment: .center, spacing: 8) {
                        Text("COLORS")
                            .font(.headline)
                        
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.horizontal, 150)
                    
                    // SIZES
                    VStack(alignment: .center, spacing: 8) {
                        HStack {
                            Text("SIZES")
                                .font(.headline)
                            Spacer()
                            Text("SIZE CHART")
                                .font(.footnote)
                                .underline()
                                .foregroundColor(.gray)
                        }
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                            ForEach(sizes, id: \.self) { size in
                                Button(action: {
                                    selectedSize = size
                                }) {
                                    Text("\(size)")
                                        .frame(width: 50, height: 40)
                                        .background(selectedSize == size ? .black : .white)
                                        .foregroundColor(selectedSize == size ? .white : .black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                }
                            }
                        }
                        
                        Text("Size Out Of Stock? ")
                            .font(.footnote)
                            .foregroundColor(.gray) +
                        Text("Notify Me")
                            .font(.footnote)
                            .underline()
                            .foregroundColor(.gray)
                    }
                    
                    Divider()
                    
                    // Expandable Sections
                    VStack(spacing: 16) {
                        AccordionItem(title: "DETAILS", isExpanded: $showDetails)
                        AccordionItem(title: "OFFERS", isExpanded: $showOffers)
                        AccordionItem(title: "REVIEWS", isExpanded: $showReviews)
                        AccordionItem(title: "DELIVERY", isExpanded: $showDelivery)
                        AccordionItem(title: "RETURNS", isExpanded: $showReturns)
                        
                        // Related Items
                        Text("YOU MAY ALSO LIKE")
                            .font(.headline)
                            .padding(.top)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(0..<12) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 160)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.gray)
                                        )
                                    
                                    Text("Product Name \(index + 1)")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    
                                    Text("₹999")
                                        .font(.footnote)
                                        .bold()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .presentationDragIndicator(.visible)
        } else {
            // Fallback on earlier versions
        } // iOS 16+ for automatic drag indicator if you prefer system version
    }
}


struct AccordionItem: View {
    let title: String
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 4) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.down" : "plus")
                        .foregroundColor(.black)
                }
            }

            if isExpanded {
                
                
                Text("Sample content for \(title).")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
            }

            Divider()
        }
    }
}

