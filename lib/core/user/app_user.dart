import 'user_role.dart'; 

class AppUser {
    
    const AppUser({
        required this.id, 
        required this.name, 
        required this.email, 
        required this.role, 
        this.patientId, 
    }); 

    final String id;

    final String name; 

    final String email;

    final UserRole role; 

    // only if user is a single patient
    final String? patientId; 

    bool get isPatient => role == UserRole.patient; 

    bool get isUser => role == UserRole.user; 

}