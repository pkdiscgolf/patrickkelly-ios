import Foundation

struct Project: Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let summary: String
    let stack: [String]
    let urlString: String
    let displayURL: String

    var url: URL { URL(string: urlString)! }
}

struct SkillGroup: Identifiable {
    var id: String { title }
    let title: String
    let icon: String
    let items: [String]
}

enum Content {
    static let siteURL = URL(string: "https://www.patrickkelly.info")!
    static let email = "pk@pkdiscgolf.com"
    static let phoneDisplay = "651-252-5960"
    static let phoneDigits = "+16512525960"

    static let eyebrow = "Software Developer & Web Designer"
    static let heroTitle = "Software and websites that help organizations run better."
    static let heroSub = """
    Based in St. Paul, MN. I design and build custom apps and websites — \
    from registration & scoring platforms for sports organizations to sites for \
    small businesses that need to look sharp and just work.
    """
    static let about = """
    I'm Patrick Kelly, a software developer and web designer focused on building practical, \
    reliable tools — whether that's a live scoring app for a tournament, a league management \
    platform for an organization with hundreds of players, or a clean, fast website for a \
    local business. I work directly with clients from first conversation to launch, and I \
    stick around to support what I build.
    """

    static let projects: [Project] = [
        Project(
            id: "kpleagues", name: "KPLeagues", image: "work_kpleagues",
            summary: "A PHP/MySQL league management platform handling registration, payments, and scheduling for Minnesota disc golf leagues. Automated standings calculations, player stat tracking, and Stripe-powered payment processing for league fees.",
            stack: ["PHP", "JavaScript", "Bootstrap", "Stripe", "MySQL"],
            urlString: "https://www.kpleagues.com", displayURL: "kpleagues.com"),
        Project(
            id: "dgportland", name: "dgPortland", image: "work_dgportland",
            summary: "A ReactJS event hub for the Portland disc golf community backed by Supabase/PostgreSQL and deployed on Vercel. Live schedules, course information, and player stats served from a fast, serverless architecture.",
            stack: ["ReactJS", "PostgreSQL", "Supabase", "Vercel", "Stripe"],
            urlString: "https://www.dgportland.com", displayURL: "dgportland.com"),
        Project(
            id: "depot", name: "KPLeagues Depot", image: "work_kpleaguesdepot",
            summary: "A custom Shopify/Liquid storefront for league apparel — hoodies, jerseys, towels, and hats — with a tailored theme and product merchandising built around the KPLeagues brand.",
            stack: ["Shopify", "Liquid"],
            urlString: "https://depot.kpleagues.com", displayURL: "depot.kpleagues.com"),
        Project(
            id: "dgscores", name: "DG Scores", image: "work_dgscores",
            summary: "A ReactJS live scoring app for disc golf events, backed by Supabase/PostgreSQL and deployed on Vercel. Real-time score entry, live leaderboards, and round history for players and spectators.",
            stack: ["ReactJS", "PostgreSQL", "Supabase", "Vercel", "Stripe"],
            urlString: "https://www.dgscores.app", displayURL: "dgscores.app"),
        Project(
            id: "norby", name: "Mike Norby Flooring", image: "work_mikenorbyflooring",
            summary: "A hand-built HTML/CSS marketing site for a flooring contractor, designed around clear calls-to-action and a simple quote request flow to generate leads.",
            stack: ["HTML", "CSS"],
            urlString: "https://www.mikenorbyflooring.com", displayURL: "mikenorbyflooring.com"),
        Project(
            id: "crm", name: "CRM", image: "work_crm",
            summary: "A self-hosted EspoCRM deployment customized for managing leads, accounts, and opportunities across sales and service workflows, with tailored fields and views for day-to-day pipeline tracking.",
            stack: ["EspoCRM", "PHP", "MySQL"],
            urlString: "https://crm.patrickkelly.info", displayURL: "crm.patrickkelly.info"),
        Project(
            id: "pkdiscgolf", name: "PK Disc Golf", image: "work_pkdiscgolfcom",
            summary: "A lightweight HTML/CSS landing page linking disc golf players to PK's projects — KPLeagues, dgPortland, DG Scores, the KPLeagues Depot store, and social channels.",
            stack: ["HTML", "CSS"],
            urlString: "https://www.pkdiscgolf.com", displayURL: "pkdiscgolf.com"),
        Project(
            id: "mndisc", name: "MNDisc", image: "work_mndisc_twins",
            summary: "Built a Laravel 13/Blade event directory on PHP 8.4 and MariaDB. Integrated JSON APIs and Google Sheets with hourly imports, duplicate detection, and transactional updates. Implemented role-based moderation, server-rendered event pages, structured Event data, XML sitemaps, and GA4 engagement tracking.",
            stack: ["Laravel 13", "PHP 8.4", "Blade", "MariaDB"],
            urlString: "https://www.mndisc.com", displayURL: "mndisc.com"),
    ]

    static let skillGroups: [SkillGroup] = [
        SkillGroup(title: "Development", icon: "chevron.left.forwardslash.chevron.right", items: [
            "Web app development (front & back end)",
            "Mobile-friendly, responsive design",
            "API design & integration",
            "Database design",
            "Data imports & scheduled automation",
        ]),
        SkillGroup(title: "Design", icon: "paintbrush.pointed", items: [
            "UI/UX for web & mobile",
            "Brand-consistent websites",
            "Landing pages & marketing sites",
            "Technical SEO & structured data",
            "Analytics & event tracking",
        ]),
        SkillGroup(title: "Working With Clients", icon: "person.2", items: [
            "Requirements & scoping",
            "Ongoing maintenance & support",
            "Hosting & deployment",
        ]),
    ]

    static let techStack = [
        "ReactJS", "Next.js", "PHP", "Laravel", "Blade", "MySQL", "MariaDB", "PostgreSQL",
        "Supabase", "Vercel", "HTML", "CSS", "JavaScript", "Tailwind CSS", "Bootstrap",
        "Shopify", "Liquid", "EspoCRM", "Square", "Stripe", "GitHub", "SEO",
        "Google Analytics 4 (GA4)", "Search Console",
    ]

    struct Social: Identifiable {
        var id: String { name }
        let name: String
        let icon: String
        let url: URL
    }

    static let socials: [Social] = [
        Social(name: "Facebook", icon: "f.circle", url: URL(string: "https://www.facebook.com/pk.discgolf.1")!),
        Social(name: "Instagram", icon: "camera", url: URL(string: "https://www.instagram.com/pk_discgolf/")!),
        Social(name: "LinkedIn", icon: "briefcase", url: URL(string: "https://www.linkedin.com/in/patrick-kelly-17750a134/")!),
    ]
}
