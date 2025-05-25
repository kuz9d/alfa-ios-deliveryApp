import UIKit

public enum BDUIComponentType: String, Codable {
    case contentView, stackView, label, button, textField
}

public struct BDUIAction: Codable {
    public let type: String
    public let context: String?
}

public struct ContentViewContent: Codable {
    public let style: String?
    public let backgroundColor: String?
}

public struct StackContent: Codable {
    public let axis: String?
    public let spacing: String?
    public let distribution: String?
    public let alignment: String?
}

public struct LabelContent: Codable {
    public let text: String
    public let style: String?
}

public struct ButtonContent: Codable {
    public let text: String
    public let style: String?
    public let action: BDUIAction?
}

public struct TextFieldContent: Codable {
    public let placeholder: String
    public let style: String?
    public let bind: String?
}

public enum BDUIContent {
    case contentView(ContentViewContent)
    case stackView(StackContent)
    case label(LabelContent)
    case button(ButtonContent)
    case textField(TextFieldContent)
}

public struct BDUIComponent: Codable {
    public let type: BDUIComponentType
    public let content: BDUIContent
    public let subviews: [BDUIComponent]?

    enum CodingKeys: String, CodingKey {
        case type, content, subviews
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        type = try c.decode(BDUIComponentType.self, forKey: .type)
        switch type {
        case .contentView:
            content = .contentView(try c.decode(ContentViewContent.self, forKey: .content))
        case .stackView:
            content = .stackView(try c.decode(StackContent.self, forKey: .content))
        case .label:
            content = .label(try c.decode(LabelContent.self, forKey: .content))
        case .button:
            content = .button(try c.decode(ButtonContent.self, forKey: .content))
        case .textField:
            content = .textField(try c.decode(TextFieldContent.self, forKey: .content))
        }
        subviews = try c.decodeIfPresent([BDUIComponent].self, forKey: .subviews)
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(type, forKey: .type)
        switch content {
        case .contentView(let cfg):
            try c.encode(cfg, forKey: .content)
        case .stackView(let cfg):
            try c.encode(cfg, forKey: .content)
        case .label(let cfg):
            try c.encode(cfg, forKey: .content)
        case .button(let cfg):
            try c.encode(cfg, forKey: .content)
        case .textField(let cfg):
            try c.encode(cfg, forKey: .content)
        }
        try c.encodeIfPresent(subviews, forKey: .subviews)
    }
}

