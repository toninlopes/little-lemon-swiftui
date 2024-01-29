import SwiftUI

struct LLGreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.all, 12)
            .background(Color(.littleLemonGreen))
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}

struct LLGreenButtonDisabled: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .frame(maxWidth: .infinity)
            .padding(.all, 12)
            .background(Color(.littleLemonGreen))
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .foregroundStyle(.white)
            .opacity(0.5)
            .disabled(true)
            
    }
}

struct LLLightButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.all, 12)
            .background(Color(.lightGray).opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(.littleLemonGreen)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}

struct LLLightButtonDisabled: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.all, 12)
            .background(Color(.lightGray).opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(.littleLemonGreen)
            .opacity(0.5)
            .disabled(true)
            
    }
}

struct LLYellowButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.all, 12)
            .background(Color(.littleLemonYellow))
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .foregroundStyle(.littleLemonGreen)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}



#Preview {
    VStack {
        Button("Green Button", action:  {})
            .buttonStyle(LLGreenButton())
        
        Button("Green Button Disabled", action:  {})
            .buttonStyle(LLGreenButtonDisabled())
        
        Button("Light Button", action:  {})
            .buttonStyle(LLLightButton())
        
        Button("Light Button Disabled", action:  {})
            .buttonStyle(LLLightButtonDisabled())
        
        Button("Yellow Button", action:  {})
            .buttonStyle(LLYellowButton())
    }
    .padding(.all)
    
}
