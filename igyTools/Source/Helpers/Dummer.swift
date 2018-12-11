
import Foundation

public class Dummer {
  
  private static let companyNames = [
    "3Com Corp",
    "3M Company",
    "A.G. Edwards Inc.",
    "Abbott Laboratories",
    "Abercrombie & Fitch Co.",
    "ABM Industries Incorporated",
    "Ace Hardware Corporation",
    "ACT Manufacturing Inc.",
    "Acterna Corp.",
    "Adams Resources & Energy, Inc.",
    "ADC Telecommunications, Inc.",
    "Adelphia Communications Corporation",
    "Administaff, Inc.",
    "Adobe Systems Incorporated",
    "Avaya Inc.",
    "Avery Dennison Corporation",
    "Avista Corporation",
    "Avnet, Inc.",
    "Avon Products, Inc.",
    "Baker Hughes Incorporated",
    "Ball Corporation",
    "Bank of America Corporation",
    "The Bank of New York Company, Inc.",
    "Bank One Corporation",
    "Banknorth Group, Inc.",
    "Baxter International Inc.",
    "BB&T Corporation",
    "Burlington Northern Santa Fe Corporation",
    "Burlington Resources Inc.",
    "Cablevision Systems Corp",
    "Cabot Corp",
    "Cadence Design Systems, Inc.",
    "Calpine Corp.",
    "Campbell Soup Co.",
    "Capital One Financial Corp.",
    "Cardinal Health Inc.",
    "Crompton Corp.",
    "Crown Cork & Seal Co. Inc.",
    "CSK Auto Corp.",
    "CSX Corp.",
    "Cummins Inc.",
    "CVS Corp.",
    "Cytec Industries Inc.",
    "D&K Healthcare Resources, Inc.",
    "D.R. Horton Inc.",
    "Dana Corporation",
    "Danaher Corporation",
    "Darden Restaurants Inc.",
    "DPL Inc.",
    "DQE Inc.",
    "Dreyer's Grand Ice Cream, Inc.",
    "DST Systems, Inc.",
    "DTE Energy Co.",
    "E.I. Du Pont de Nemours and Company",
    "Duke Energy Corp",
    "Dun & Bradstreet Inc.",
    "DURA Automotive Systems Inc.",
    "DynCorp",
    "Dynegy Inc.",
    "E*Trade Group, Inc.",
    "E.W. Scripps Company",
    "Earthlink, Inc.",
    "Expeditors International of Washington Inc.",
    "Express Scripts Inc.",
    "ExxonMobil Corporation",
    "Fairchild Semiconductor International Inc.",
    "Family Dollar Stores Inc.",
    "Farmland Industries Inc.",
    "Federal Mogul Corp.",
    "Ford Motor Co",
    "Franklin Resources Inc.",
    "Freeport McMoran Copper & Gold Inc.",
    "Frontier Oil Corp",
    "Furniture Brands International Inc.",
    "Gannett Co., Inc.",
    "Gap Inc.",
    "Gateway Inc.",
    "GATX Corporation",
    "Gemstar-TV Guide International Inc.",
    "GenCorp Inc.",
    "General Motors Corporation",
    "Group 1 Automotive Inc.",
    "Guidant Corporation",
    "H&R Block Inc.",
    "H.B. Fuller Company",
    "H.J. Heinz Company",
    "Halliburton Co.",
    "Harley-Davidson Inc.",
    "Hubbell Inc.",
    "Hughes Supply Inc.",
    "Humana Inc.",
    "Huntington Bancshares Inc.",
    "Idacorp Inc.",
    "IDT Corporation",
    "IKON Office Solutions Inc.",
    "Illinois Tool Works Inc.",
    "IMC Global Inc.",
    "Intuit Inc.",
    "IT Group Inc.",
    "ITT Industries Inc.",
    "Ivax Corp.",
    "J.B. Hunt Transport Services Inc.",
    "J.C. Penny Co.",
    "J.P. Morgan Chase & Co.",
    "Jabil Circuit Inc.",
    "Jack In The Box Inc.",
    "Jacobs Engineering Group Inc.",
    "JDS Uniphase Corp.",
    "Jefferson-Pilot Co.",
    "John Hancock Financial Services Inc.",
    "Johnson & Johnson",
    "Johnson Controls Inc.",
    "Jones Apparel Group Inc.",
    "KB Home",
    "Kimball International Inc.",
    "Kimberly-Clark Corporation",
    "Kindred Healthcare Inc.",
    "KLA-Tencor Corporation",
    "K-Mart Corp.",
    "Knight-Ridder Inc.",
    "Kohl's Corp.",
    "KPMG Consulting Inc.",
    "Kroger Co.",
    "L-3 Communications Holdings Inc.",
    "Laboratory Corporation of America Holdings",
    "Lam Research Corporation",
    "Louisiana-Pacific Corporation",
    "Lowe's Companies Inc.",
    "LSI Logic Corporation",
    "The LTV Corporation",
    "The Lubrizol Corporation",
    "Lucent Technologies Inc.",
    "Lyondell Chemical Company",
    "M & T Bank Corporation",
    "Magellan Health Services Inc.",
    "Mail-Well Inc.",
    "Mandalay Resort Group",
    "Maxim Integrated Products Inc.",
    "Maxtor Corporation",
    "Maxxam Inc.",
    "The May Department Stores Company",
    "Maytag Corporation",
    "MBNA Corporation",
    "McCormick & Company Incorporated",
    "McDonald's Corporation",
    "Milacron Inc.",
    "Millennium Chemicals Inc.",
    "Mirant Corporation",
    "Mohawk Industries Inc.",
    "Molex Incorporated",
    "The MONY Group Inc.",
    "Morgan Stanley Dean Witter & Co.",
    "Motorola Inc.",
    "MPS Group Inc.",
    "Murphy Oil Corporation",
    "Nabors Industries Inc",
    "Nacco Industries Inc",
    "Nash Finch Company",
    "National City Corp.",
    "Navistar International Corporation",
    "NCR Corporation",
    "The Neiman Marcus Group Inc.",
    "New Jersey Resources Corporation",
    "New York Times Company",
    "Nvidia Corp",
    "NVR Inc",
    "Northwest Airlines Corp",
    "Occidental Petroleum Corp",
    "Ocean Energy Inc",
    "Office Depot Inc.",
    "Old Republic International Corp.",
    "Olin Corp.",
    "OM Group Inc",
    "Omnicare Inc",
    "Omnicom Group",
    "On Semiconductor Corp",
    "ONEOK Inc",
    "Oracle Corp",
    "Oshkosh Truck Corp",
    "Outback Steakhouse Inc.",
    "Owens & Minor Inc.",
    "Owens Corning",
    "Owens-Illinois Inc",
    "Oxford Health Plans Inc",
    "Paccar Inc",
    "PacifiCare Health Systems Inc",
    "Packaging Corp. of America",
    "Pactiv Corp",
    "PepsiCo Inc.",
    "PSS World Medical Inc",
    "Public Service Enterprise Group Inc.",
    "Publix Super Markets Inc.",
    "Puget Energy Inc.",
    "Pulte Homes Inc",
    "Qualcomm Inc",
    "Quanta Services Inc.",
    "Quantum Corp",
    "Quest Diagnostics Inc.",
    "Questar Corp",
    "Quintiles Transnational",
    "Qwest Communications Intl Inc",
    "R.J. Reynolds Tobacco Company",
    "R.R. Donnelley & Sons Company",
    "Radio Shack Corporation",
    "Raymond James Financial Inc.",
    "Raytheon Company",
    "Reader's Digest Association Inc.",
    "Rent A Center Inc",
    "Republic Services Inc",
    "Revlon Inc",
    "RGS Energy Group Inc",
    "Rite Aid Corp",
    "Riverwood Holding Inc.",
    "RoadwayCorp",
    "Robert Half International Inc.",
    "Rock-Tenn Co",
    "Rockwell Automation Inc",
    "Rockwell Collins Inc",
    "Rohm & Haas Co.",
    "Ross Stores Inc",
    "RPM Inc.",
    "Ruddick Corp",
    "Ryder System Inc",
    "Ryerson Tull Inc",
    "Ryland Group Inc.",
    "Sabre Holdings Corp",
    "Safeco Corp",
    "Safeguard Scientifics Inc.",
    "Sports Authority Inc",
    "Sprint Corp.",
    "SPX Corp",
    "St. Jude Medical Inc",
    "St. Paul Cos.",
    "Staff Leasing Inc.",
    "Steelcase Inc",
    "Stein Mart Inc",
    "Stewart & Stevenson Services Inc",
    "Stewart Information Services Corp",
    "Stilwell Financial Inc",
    "Storage Technology Corporation",
    "Target Corp.",
    "Tech Data Corporation",
    "Textron Inc",
    "Thermo Electron Corporation",
    "Thomas & Betts Corporation",
    "Tiffany & Co",
    "Timken Company",
    "TJX Companies Inc",
    "TMP Worldwide Inc",
    "Toll Brothers Inc",
    "Trinity Industries Inc",
    "Trump Hotels & Casino Resorts Inc.",
    "TruServ Corporation",
    "TRW Inc",
    "TXU Corp",
    "Tyson Foods Inc",
    "U.S. Bancorp",
    "U.S. Industries Inc.",
    "UAL Corporation",
    "UGI Corporation",
    "Unified Western Grocers Inc",
    "Universal Corporation",
    "Unocal Corporation",
    "Unova Inc",
    "UnumProvident Corporation",
    "URS Corporation",
    "US Airways Group Inc",
    "US Oncology Inc",
    "USA Interactive",
    "USFreighways Corporation",
    "USG Corporation",
    "UST Inc",
    "Valero Energy Corporation",
    "Valspar Corporation",
    "Value City Department Stores Inc",
    "Varco International Inc",
    "Vectren Corporation",
    "Volt Information Sciences Inc",
    "Vulcan Materials Company",
    "W.R. Berkley Corporation",
    "W.R. Grace & Co",
    "W.W. Grainger Inc",
    "Wachovia Corporation",
    "Wakenhut Corporation",
    "Walgreen Co",
    "Wallace Computer Services Inc",
    "Wal-Mart Stores Inc",
    "Walt Disney Co",
    "Williams Companies Inc",
    "Williams Sonoma Inc",
    "Winn Dixie Stores Inc",
    "Wisconsin Energy Corporation",
    "Wm Wrigley Jr Company",
    "World Fuel Services Corporation",
    "WorldCom Inc",
    "Worthington Industries Inc",
    "WPS Resources Corporation",
    "Wyeth",
    "Wyndham International Inc",
    "Xcel Energy Inc",
    "Xerox Corp",
    "Xilinx Inc",
    "XO Communications Inc",
    "Yellow Corporation",
    "York International Corp",
    "Yum Brands Inc.",
    "Zale Corporation",
    "Zions Bancorporation"
  ]
  
  private static let firstNames = [
    "Delores",
    "Joshua",
    "Karla",
    "Yolanda",
    "Andy",
    "Emily",
    "Jody",
    "Alexander",
    "Fred",
    "Allison"
  ]
  
  private static let lastNames = [
    "Patterson",
    "Poole",
    "Kennedy",
    "Schmidt",
    "Patton",
    "Smith",
    "Drake",
    "Fletcher",
    "Pierce",
    "Hansen"
  ]
  
  private static let photoUrls = [
    "http://wallpaper-gallery.net/images/nice-pics/nice-pics-11.jpg",
    "https://upload.wikimedia.org/wikipedia/ru/3/34/Frodo.jpg",
    "https://upload.wikimedia.org/wikipedia/ru/c/c2/Bilbo_B.jpg",
    "https://pbs.twimg.com/profile_images/606127088668672000/X2Y0BcXi.jpg",
    "http://www.theargonath.cc/pictures/misctwotowers/misctwotowers88.jpg",
    "http://dl9fvu4r30qs1.cloudfront.net/78/01/eefa1fdd42fb9769de0652eb7492/viggo-mortensen-lord-of-the-rings.jpg",
    "http://static.comicvine.com/uploads/original/11124/111240706/4798935-saurons.jpg",
    "http://66.media.tumblr.com/0a6cec1b73fa2939c4897738dadcda95/tumblr_inline_n53fblWCY01rnrk68.jpg",
    "http://project3tpach.weebly.com/uploads/4/3/2/9/43292817/5044395_orig.png",
    "http://vignette4.wikia.nocookie.net/lotr/images/2/20/Sam.jpg",
    "http://2.bp.blogspot.com/-40ZIQRzYGR8/T61g43odpGI/AAAAAAAAAFM/Lmy-6NO4rBA/s1600/boromi3.jpg",
    "http://middle-earthencyclopedia.weebly.com/uploads/3/8/2/9/3829140/7824820.png",
    "https://s-media-cache-ak0.pinimg.com/736x/aa/6d/b4/aa6db4385e09189facae774a1637ea33.jpg",
    "http://www.planetware.com/photos-large/F/france-nice-jardins-albert.jpg",
    "http://i.dailymail.co.uk/i/pix/2016/07/15/18/364AD95400000578-3691019-Icon_The_sweeping_promenade_of_Nice_with_its_famous_twinkling_st-a-48_1468604671797.jpg",
    "http://i.imgur.com/UHf46gr.jpg",
    "http://i.imgur.com/9A92N5X.jpg",
    "http://i.imgur.com/68XJXca.jpg",
    "http://i.imgur.com/RrW2og9.jpg",
    "http://i.imgur.com/C3km38W.jpg",
    "http://i.imgur.com/guBuf4B.jpg",
    "http://i.imgur.com/w8brwCW.jpg",
    "http://i.imgur.com/RZUKlSD.jpg",
    "http://i.imgur.com/dpKhXCn.jpg",
    "http://i.imgur.com/daP1BPd.jpg",
    "http://i.imgur.com/Iy39Ujm.jpg",
    "http://i.imgur.com/k4Wioqe.jpg",
    "http://i.imgur.com/6cW0caQ.jpg",
    "http://i.imgur.com/lHiLBIx.jpg",
    "http://i.imgur.com/qrLjxhr.jpg",
    "http://i.imgur.com/u3Zg9b7.jpg",
    "http://i.imgur.com/JNIoUqw.jpg",
    "http://i.imgur.com/O6CCE29.jpg",
    "http://i.imgur.com/2VGol98.jpg",
    "http://i.imgur.com/g7WWuKf.jpg",
    "http://i.imgur.com/EkDq1ic.jpg",
    "http://i.imgur.com/2Byqw87.jpg",
    "http://i.imgur.com/eqaifQ0.jpg",
    "http://i.imgur.com/Qkibv5r.jpg",
    "http://i.imgur.com/n9v53uL.jpg",
    "http://i.imgur.com/fjDIsLC.jpg"
  ]
  
  private static let vaingloryNames = ["Adagio", "Alpha", "Ardan", "Blackfeather", "Catherine", "Celeste", "Fortress", "Glaive", "Joule", "Kestrel", "Koshka", "Krul", "Lance", "Ozo", "Petal", "Phinn", "Reim", "Ringo", "Rona", "Saw", "Skaarf", "Skye", "Taka", "Vox"]
  
  private static let vaingloryNickNames = ["Healer", "Explosive Robot", "Revenge Man", "Heart Eater", "Miss Fabulous", "Nuclear Reactor", "Doggy Dog", "Axe Cat", "Mexa Girl", "Sniper", "Kitty Claw", "Disturbed", "Longhanded Protector", "Funny Monkey", "Weird Creature", "Calm n Slow", "Cold Grandfather", "Drunk Shooter", "Rude Girl", "Spin me Hard", "BBQ Fly", "Jet Girl", "Invisible Ninja", "Fast n Loud"]
  
  private static let vaingloryHeroes = [
    "http://www.vaingloryfire.com/images/heroes/potrait/adagio.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/alpha.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/ardan.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/blackfeather.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/catherine.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/celeste.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/fortress.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/glaive.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/joule.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/kestrel.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/koshka.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/krul.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/lance.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/ozo.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/petal.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/phinn.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/reim.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/ringo.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/rona.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/saw.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/skaarf.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/skye.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/taka.png",
    "http://www.vaingloryfire.com/images/heroes/potrait/vox.png"
  ]
  
  private static let streets = [
    "7514 Military St.",
    "9001 Hamilton Ave.",
    "121 Valley Farms Street",
    "5 High Point St.",
    "300 Tailwater Dr.",
    "158 West Alton Dr.",
    "8034 Winding Way Dr.",
    "200 Beechwood Rd.",
    "64 Broad Dr.",
    "375 Glen Eagles Ave.",
    "143 Talbot Street",
    "8326 Harvard St.",
    "9524 Ridge Drive",
    "7174 Berkshire Lane",
    "679 North Drive",
    "637 Lakeshore Drive",
    "7662 Prospect Street",
    "494 South Wild Rose Street",
    "260 Lower River Ave.",
    "7658 Primrose St.",
    "9971 Manor St.",
    "27 Parker St.",
    "5 Holly Lane",
    "241 Shipley Ave."
  ]
  
  private static let cities = [
    "Glen Burnie",
    "Highland",
    "Hackettstown",
    "Bartlett",
    "Revere",
    "Ontario",
    "Belleville",
    "Halethorpe",
    "Buffalo",
    "Fremont",
    "Holbrook",
    "Midland",
    "Bethlehem",
    "West Orange",
    "West Babylon",
    "Jeffersonville",
    "Harleysville",
    "Iowa City",
    "Glendale",
    "Suwanee",
    "Champlin",
    "Lapeer",
    "Tallahassee",
    "Solon"
  ]
  
  private static let states = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi"
  ]
  
  private static let countries = [
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, North",
    "Korea, South",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Top of Page",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Top of Page",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Korea",
    "Norway",
    "Top of Page",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestinian Territories",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal"
  ]
  
  public static func allStateNames() -> [String] {
    return states
  }
  
  public static func count() -> Int{
    return vaingloryHeroes.count
  }
  
  public static func id() -> String{
    return UUID().uuidString
  }
  
  public static func firstName() -> String{
    return firstNames[Int(arc4random_uniform(UInt32(firstNames.count)))]
  }
  
  public static func lastName() -> String{
    return lastNames[Int(arc4random_uniform(UInt32(lastNames.count)))]
  }
  
  public static func photoUrl() -> String{
    return photoUrls[Int(arc4random_uniform(UInt32(photoUrls.count)))]
  }
  
  public static func vgUserSet() -> (name:String, nickName:String, photoUrlString:String){
    let num = Int(arc4random_uniform(UInt32(vaingloryHeroes.count)))
    return (name: vaingloryNames[num], nickName: vaingloryNickNames[num], photoUrlString:vaingloryHeroes[num])
  }
  
  public static func vgName() -> String{
    return vaingloryNames[Int(arc4random_uniform(UInt32(vaingloryNames.count)))]
  }
  
  public static func vgNickName() -> String{
    return vaingloryNickNames[Int(arc4random_uniform(UInt32(vaingloryNickNames.count)))]
  }
  
  public static func imageUrlString() -> String{
    return vaingloryHeroes[Int(arc4random_uniform(UInt32(vaingloryHeroes.count)))]
  }
  
  public static func street() -> String{
    return streets[Int(arc4random_uniform(UInt32(streets.count)))]
  }
  
  public static func city() -> String{
    return cities[Int(arc4random_uniform(UInt32(cities.count)))]
  }
  
  public static func companyName() -> String{
    return companyNames[Int(arc4random_uniform(UInt32(companyNames.count)))]
  }
  
  public static func state() -> String{
    return states[Int(arc4random_uniform(UInt32(states.count)))]
  }
  
  public static func country() -> String{
    return countries[Int(arc4random_uniform(UInt32(countries.count)))]
  }
  
  public static func zipCode() -> String{
    return "\(numbers(count: 5))"
  }
  
  public static func flipCoin() -> Bool{
    return arc4random_uniform(2) == 0
  }
  
  public static func webSite() -> String{
    return "www.a\(loremIpsum(limiter: 12).withoutSpacesAndNewLines).com"
  }
  
  public static func email() -> String{
    return "a\(loremIpsum(limiter: 6))@b\(loremIpsum(limiter: 6).withoutSpacesAndNewLines).mail"
  }
  
  public static func element<G>(ofArray array: [G]) -> G {
    return array[Int(arc4random_uniform(UInt32(array.count)))]
  }
  
  public static func numbers(count:Int) -> Int{
    var digitString = ""
    for _ in 0..<count {
      digitString.append("\(Int(arc4random_uniform(10)))")
    }
    return Int(digitString)!
  }
  
  public static func phone() -> String {
    return "+(\(numbers(count: 2))) \(numbers(count: 3)) \(numbers(count: 3)) \(numbers(count: 2)) \(numbers(count: 2)))"
  }
  
  public static func number(limiter:Int) -> Int{
    return Int(arc4random_uniform(UInt32(limiter)))
  }
  
  public static func progress() -> Double {
    let hundred = number(limiter: 100)
    return (Double(hundred)/100)
  }
  
  public static func date(future: Bool = false) -> Date {
    return Date(timeIntervalSinceNow: future ? TimeInterval(number(limiter: 10000000)) : -TimeInterval(number(limiter: 10000000)))
  }
  
  public static func loremIpsum(limiter:Int = 0) -> String{
    let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc tincidunt purus maximus condimentum fringilla. Cras at lacus vitae diam vulputate interdum. Suspendisse bibendum ullamcorper odio ut vulputate. Nunc tristique eros nec consectetur sagittis. Morbi non hendrerit mauris, nec pretium velit. Sed vestibulum enim bibendum mi scelerisque vulputate. Proin quis luctus risus, non ultrices massa. In elementum finibus purus in vehicula. Vivamus viverra arcu eros, in porta augue mollis at. Maecenas sit amet ipsum ac sem lacinia mollis eget et odio. Integer luctus dui sit amet tristique pellentesque. Nam vitae nisi ex. In mauris orci, pretium interdum scelerisque semper, dictum id nunc. Nullam mattis rhoncus turpis. Maecenas eleifend viverra purus, id pretium ligula mattis vitae. Morbi rutrum ligula ac tempor iaculis. Aliquam maximus odio at diam condimentum elementum. Etiam velit ante, rhoncus in felis vitae, lobortis lobortis dolor. Duis fermentum, turpis vel finibus tempus, arcu ligula viverra ipsum, vel suscipit mi lectus ac quam. Mauris convallis, orci in congue egestas, nisl metus maximus sapien, quis lobortis ex dui et dolor. Duis at aliquet ipsum, ut imperdiet diam. Morbi dictum, elit sed finibus porta, est velit accumsan justo, eu porta neque est vestibulum ante. Aliquam scelerisque diam sapien, ac venenatis leo venenatis non. Fusce vestibulum condimentum ultricies. Proin semper, nunc vitae dictum malesuada, est lorem pulvinar arcu, ut accumsan augue sem in turpis. Nam aliquet venenatis gravida. Donec lacinia eget neque ac sagittis."
    var randomCharacter = Int(arc4random_uniform(UInt32(loremIpsum.count)))
    if limiter != 0 && randomCharacter > limiter {
      randomCharacter = Int(arc4random_uniform(UInt32(limiter)))
    }
    
    let range = loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: randomCharacter)
    let subtring = loremIpsum[range]
    
    return String(subtring)
  }
}

