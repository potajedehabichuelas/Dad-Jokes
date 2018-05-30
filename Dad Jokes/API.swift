//  This file was automatically generated and should not be edited.

import Apollo

public final class JokeDetailsQuery: GraphQLQuery {
  public static let operationString =
    "query JokeDetails {\n  joke {\n    __typename\n    id\n    joke\n    permalink\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("joke", type: .object(Joke.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(joke: Joke? = nil) {
      self.init(snapshot: ["__typename": "Query", "joke": joke.flatMap { (value: Joke) -> Snapshot in value.snapshot }])
    }

    public var joke: Joke? {
      get {
        return (snapshot["joke"] as? Snapshot).flatMap { Joke(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "joke")
      }
    }

    public struct Joke: GraphQLSelectionSet {
      public static let possibleTypes = ["Joke"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("joke", type: .scalar(String.self)),
        GraphQLField("permalink", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, joke: String? = nil, permalink: String? = nil) {
        self.init(snapshot: ["__typename": "Joke", "id": id, "joke": joke, "permalink": permalink])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var joke: String? {
        get {
          return snapshot["joke"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "joke")
        }
      }

      public var permalink: String? {
        get {
          return snapshot["permalink"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "permalink")
        }
      }
    }
  }
}